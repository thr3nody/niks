{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpicker
  ];
}
