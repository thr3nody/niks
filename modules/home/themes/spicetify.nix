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
      {
        src =
          (pkgs.fetchFromGitHub {
            owner = "huhridge";
            repo = "huh-spicetify-extensions";
            rev = "d58201e27716df86ace457a82dce980175c2d65d";
            hash = "sha256-ZJJC7mGsM6H8rEfX82CF0kkv/2MYHehN+nS7FktV/t4=";
          })
          + /fullAppDisplayModified;

        name = "fullAppDisplayMod.js";
      }
    ];

    # Give up finding a good theme.
  };
}
