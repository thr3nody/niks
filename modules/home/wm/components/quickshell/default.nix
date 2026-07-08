{pkgs, ...}: {
  home.packages = [
    pkgs.brightnessctl
  ];

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."quickshell" = {
    source = ./confs;
    recursive = false;
  };
}
