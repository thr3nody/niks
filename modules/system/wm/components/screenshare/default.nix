{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wm.components.screenshare.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables wm screensharing (xdg portal).";
    };
  };

  config = lib.mkIf config.wm.components.screenshare.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
    };
  };
}
