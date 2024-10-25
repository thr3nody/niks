{ inputs, pkgs, ... }:

{
  programs.spicetify = 
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.dribbblish;
    colorScheme = "gruvbox-material-dark";
  };
}
