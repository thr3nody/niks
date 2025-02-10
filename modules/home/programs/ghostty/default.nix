{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "gruvbox-material-medium-dark";
      font-family = "FiraCode Nerd Font Mono";
      font-size = 12;
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
      ];
      window-padding-x = 2;
      window-padding-y = 2;
    };
    themes = {
      gruvbox-material-medium-dark = {
        background = "#282828";
        foreground = "#d4be98";
        cursor-color = "#d4be98";
        selection-background = "#3c3836";
        selection-foreground = "#d4be98";
        palette = [
          "0=#1b1b1b"
          "1=#ea6962"
          "2=#a9b665"
          "3=#d8a657"
          "4=#7daea3"
          "5=#d3869b"
          "6=#89b482"
          "7=#d4be98"
          "8=#32302f"
          "9=#ea6962"
          "10=#a9b665"
          "11=#d8a657"
          "12=#7daea3"
          "13=#d3869b"
          "14=#89b482"
          "15=#d4be98"
        ];
      };
    };
  };
}
