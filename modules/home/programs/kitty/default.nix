{
  imports = [
    ./keybindings.nix
    ./settings.nix
  ];

  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark-soft";
    font = {
      name = "FiraCode";
      size = 11;
    };
  };
}
