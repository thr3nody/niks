{
  pkgs,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # Styling Look like this, goes from darker color (top) to lighter color (bottom).
    # Name    Value                 Example with #${palette.baseXX}
    # base00: "282828" # ----       #282828
    # base01: "3c3836" # ---        #3c3836
    # base02: "504945" # --         #504945
    # base03: "665c54" # -          #665c54
    # base04: "bdae93" # +          #bdae93
    # base05: "d5c4a1" # ++         #d5c4a1
    # base06: "ebdbb2" # +++        #ebdbb2
    # base07: "fbf1c7" # ++++       #fbf1c7
    # base08: "fb4934" # red        #fb4934
    # base09: "fe8019" # orange     #fe8019
    # base0A: "fabd2f" # yellow     #fabd2f
    # base0B: "b8bb26" # green      #b8bb26
    # base0C: "8ec07c" # aqua/cyan  #8ec07c
    # base0D: "83a598" # blue       #83a598
    # base0E: "d3869b" # purple     #d3869b
    # base0F: "d65d0e" # brown      #d65d0e
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      inherit (config.colorScheme) palette;
    in {
      "*" = {
        font = "Inter 11";
        backgound-color = mkLiteral "transparent";
        text-color = mkLiteral "#${palette.base06}";
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        background-color = mkLiteral "#${palette.base01}";

        location = mkLiteral "center";
        width = 622;
        border-radius = 10;
      };

      inputbar = {
        expand = false;
        filename = "search";
        size = mkLiteral "24px";
      };

      "icon-search, entry, element-icon, element-text" = {
        vertical-align = 0.5;
      };

      entry = {
        font = mkLiteral "inherit";
        placeholder = "Search";
        placeholder-color = mkLiteral "#${palette.base06}";
      };

      message = {
        border = mkLiteral "2px 0 0";
        border-color = mkLiteral "#${palette.base04}";
      };

      textbox = {
        padding = mkLiteral "8px 24px";
      };
    };
  };
}
