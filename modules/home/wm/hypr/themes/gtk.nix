{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "gruvbox-gtk-theme";
    };

    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "gruvbox-plus-icons";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
