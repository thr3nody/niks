{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    inter

    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];
}
