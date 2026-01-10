{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "eDP-1";
          path = "~/niks/modules/system/themes/wallpaper/gruv-drinks.png";
          fit_mode = "cover";
        }
      ];
      ipc = true;
      splash = false;
    };
  };
}
