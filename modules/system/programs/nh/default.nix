{
  lib,
  config,
  ...
}: {
  options = {
    progs.nh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables nh.";
    };
  };

  config = lib.mkIf config.progs.nh.enable {
    programs.nh = {
      enable = true;
      flake = "$HOME/niks/";
    };
  };
}
