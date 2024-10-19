{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}./colors/gruvbox-dark-soft.yaml";
    image = ./wallpaper/gruv-estimate.png;
  };
}
