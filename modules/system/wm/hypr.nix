{
  imports = [
    ./components/picker.nix
    ./components/screenshare.nix
  ];
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}
