{pkgs, ...}: {
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.color-picker
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
  ];

  # Gnome SysTray
  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];
}
