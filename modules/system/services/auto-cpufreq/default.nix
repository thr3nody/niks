{
  lib,
  config,
  ...
}: let
  cfg = config.svcs.auto-cpufreq;
  governorType = lib.types.enum ["powersave" "performance" "schedutil" "ondemand"];
  turboType = lib.types.enum ["auto" "always" "never"];

  profileOptions = defaults: {
    governor = lib.mkOption {
      type = governorType;
      default = defaults.governor;
      description = "CPU freq governor.";
    };
    turbo = lib.mkOption {
      type = turboType;
      default = defaults.turbo;
      description = "Turbo boost behavior.";
    };
  };
in {
  options = {
    svcs.auto-cpufreq = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables auto-cpufreq.";
      };
      battery = profileOptions {
        governor = "powersave";
        turbo = "never";
      };
      charger = profileOptions {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  config = lib.mkIf config.svcs.auto-cpufreq.enable {
    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          inherit (cfg.battery) governor turbo;
        };
        charger = {
          inherit (cfg.charger) governor turbo;
        };
      };
    };
  };
}
