{
  lib,
  config,
  ...
}: {
  options = {
    netSetup.resolved.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables systemd resolved.";
    };
  };

  config = lib.mkIf config.netSetup.resolved.enable {
    networking = {
      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      resolvconf.enable = false;
    };
    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = ["~."];
      fallbackDns = ["1.1.1.1" "1.0.0.1"];
      dnsovertls = "true";
      extraConfig = ''
        DNSStubListener=no
      '';
    };
  };
}
