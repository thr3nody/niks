{pkgs, ...}: {
  # home.pointerCursor = let
  #   getFrom = url: hash: name: {
  #     gtk.enable = true;
  #     x11.enable = true;
  #     package = pkgs.runCommand "moveUp" {} ''
  #       mkdir -p $out/share/icons
  #       ln -s ${pkgs.fetchzip {
  #         url = url;
  #         hash = hash;
  #       }} $out/share/icons/${name}
  #     '';
  #     name = name;
  #     size = 24;
  #   };
  # in
  #   getFrom
  #   "https://github.com/ful1e5/fuchsia-cursor/releases/download/v2.0.0/Fuchsia-Pop.tar.gz"
  #   "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
  #   "Fuchsia-Pop";

  # Bibata broken damn
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
