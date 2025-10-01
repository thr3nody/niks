{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Classic";

    # package = pkgs.pokemon-cursor;
    # name = "Pokemon";

    package = pkgs.banana-cursor;
    name = "Banana";

    size = 24;
  };
}
