{
  lib,
  config,
  ...
}: {
  options = {
    progs.thunderbird.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables Thunderbird email client.";
    };
  };

  config = lib.mkIf config.progs.thunderbird.enable {
    programs.thunderbird.enable = true;
  };
}
