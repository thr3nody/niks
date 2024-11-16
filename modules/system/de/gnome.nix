{
  pkgs,
  lib,
  ...
}: {
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  services = {
    # Enable
    xserver.desktopManager.gnome.enable = true;
    # Gnome SysTray
    udev.packages = with pkgs; [
      gnome-settings-daemon
    ];
    # Gnome keyring
    gnome.gnome-keyring.enable = true;
  };

  environment = {
    sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkForce "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];
    systemPackages = with pkgs; [
      gnomeExtensions.paperwm
      gnomeExtensions.color-picker
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.appindicator
      nautilus-python
    ];
  };
}
