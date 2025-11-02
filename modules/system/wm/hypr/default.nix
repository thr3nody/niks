{
  lib,
  config,
  ...
}: {
  options = {
    wm.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables hyprland wm.";
    };
  };

  config = lib.mkIf config.wm.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
