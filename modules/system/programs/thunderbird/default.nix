{
  lib,
  config,
  ...
}: {
  options = {
    prog.thunderbird.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables Thunderbird email client.";
    };
  };

  config = lib.mkIf config.prog.thunderbird.enable {
    programs.thunderbird.enable = true;
  };
}
