{
  imports = [
    ./keybindings.nix
  ];

  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    font = {
      name = "FiraCode";
      size = 11;
    };
  };
}
