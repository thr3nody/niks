{pkgs, ...}: {
  services = {
    # Enable 
    xserver.desktopManager.gnome.enable = true;
    # Gnome SysTray
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
    # Gnome keyring
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.color-picker
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
  ];

}
