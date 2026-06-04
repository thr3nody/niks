{
  lib,
  config,
  ...
}: {
  options = {
    progs.seahorse.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables Seahorse.";
    };
  };

  config = lib.mkIf config.progs.seahorse.enable {
    programs.seahorse.enable = true;
  };
}
