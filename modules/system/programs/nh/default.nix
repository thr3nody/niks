{
  lib,
  config,
  ...
}: {
  options = {
    prog.nh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables nh.";
    };
  };

  config = lib.mkIf config.prog.nh.enable {
    programs.nh = {
      enable = true;
      flake = "$HOME/niks/";
    };
  };
}
