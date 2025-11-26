{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      lyricsPlus
    ];

    theme = {
      name = "Gruvify";
      src = pkgs.fetchFromGitHub {
        owner = "Skaytacium";
        repo = "Gruvify";
        rev = "8450593f03545defb8d490bbfef66b19e60ab7c0";
        hash = "sha256-XMW6bkpMtci7dSz94SGkX03YSEMfxBX9+eltnOfsiDs=";
      };
      injectCss = true;
      injectThemeJs = true;
      replaceColors = true;
      homeConfig = true;
      overwriteAssets = false;
      additonalCss = "";
    };

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      copyLyrics
      hidePodcasts
    ];
  };
}
