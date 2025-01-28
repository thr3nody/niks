{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
    };

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    printing.enable = true;
  };
}
