{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    prog.gnupg.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables gnupg agent.";
    };
  };

  config = lib.mkIf config.prog.gnupg.enable {
    programs.gnupg = {
      package = pkgs.gnupg;
      agent.enable = true;
    };
  };
}
