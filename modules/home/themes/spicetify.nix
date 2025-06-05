{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
    ];

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      copyLyrics
      hidePodcasts
    ];
  };
}
