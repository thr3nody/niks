{
  inputs,
  pkgs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "gruvbox";
  };
}
