{ ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/niks/modules/system/themes/wallpaper/gruv-estimate.png"
      ];
      wallpaper = [
        ",$HOME/niks/modules/system/themes/wallpaper/gruv-estimate.png"
      ];
    };
  };
}
