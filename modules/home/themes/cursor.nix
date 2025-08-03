{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    # package = pkgs.bibata-cursors;
    package = pkgs.pokemon-cursor;
    # name = "Bibata-Modern-Classic";
    name = "Pokemon";
    size = 24;
  };
}
