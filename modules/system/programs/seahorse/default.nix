{
  lib,
  config,
  ...
}: {
  options = {
    prog.seahorse.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables Seahorse.";
    };
  };

  config = lib.mkIf config.prog.seahorse.enable {
    programs.seahorse.enable = true;
  };
}
