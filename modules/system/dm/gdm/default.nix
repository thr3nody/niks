{
  lib,
  config,
  ...
}: {
  options = {
    dm.gdm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables Gnome Display Manger.";
    };
  };

  config = lib.mkIf config.dm.gdm.enable {
    services.xserver.displayManager.gdm.enable = true;
  };
}
