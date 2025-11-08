{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    prog.thunar.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables Thunar file manager.";
    };
  };

  config = lib.mkIf config.prog.thunar.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
          thunar-vcs-plugin
          thunar-media-tags-plugin
        ];
      };

      # If xfce is not used as desktop and therefore xfconf is not enabled, preference changes are discarded. In that case enable the xfconf program manually to be able to save preferences.
      xfconf.enable = true;

      # Archive manager
      file-roller.enable = true;
    };

    services = {
      gvfs.enable = true; # Mount, trash, and other functionalities
      tumbler.enable = true; # Thumbnail support for images
    };
  };
}
