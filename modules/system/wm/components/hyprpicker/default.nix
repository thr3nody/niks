{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wm.components.hyprpicker.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables color picker with hyprpicker.";
    };
  };

  config = lib.mkIf config.wm.components.hyprpicker.enable {
    environment.systemPackages = with pkgs; [
      hyprpicker
    ];
  };
}
