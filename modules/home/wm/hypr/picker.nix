{ pkgs, ... }:

{
  home.package = with pkgs; [
    hyprpicker
  ];
}
