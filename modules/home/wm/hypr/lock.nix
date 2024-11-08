{ config, ... }:

{
  # Styling Look like this, goes from darker color (top) to lighter color (bottom).
  # base00: "282828" # ----
  # base01: "3c3836" # ---
  # base02: "504945" # --
  # base03: "665c54" # -
  # base04: "bdae93" # +
  # base05: "d5c4a1" # ++
  # base06: "ebdbb2" # +++
  # base07: "fbf1c7" # ++++
  # base08: "fb4934" # red
  # base09: "fe8019" # orange
  # base0A: "fabd2f" # yellow
  # base0B: "b8bb26" # green
  # base0C: "8ec07c" # aqua/cyan
  # base0D: "83a598" # blue
  # base0E: "d3869b" # purple
  # base0F: "d65d0e" # brown

  programs.hyprlock = {
    enable = true;
    settings = with config.colorScheme.palette; {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
        no_fade_out = false;
        grace = 0;
        ignore_empty_input = true;
      };

      background = [
        {
          path = "$HOME/Pictures/taipestory.jpeg";
          brightness = 0.7;
          contrast = 0.8;
        }
      ];

      input-field = [
        {
          size = "256, 64";
          position = "0, -200";
          monitor = "";
          dots_center = true;
          fade_on_empty = true;
          font_color = "rgba(${base0A}ee)";
          inner_color = "rgba(${base0E}ee)";
          outer_color = "rgba(${base0A}ee)";
          outline_thickness = 2;
          shadow_passes = 2;
          shadow_size = 2;
          shadow_color = "rgba(${base09}ee)";
          placeholder_text = "<i>Input Password...</i>";
          check_color = "rgba(${base06}ee)";
          fail_color = "rgba(${base08}ee)";
        }
      ];

      label = [
        { # Time
          text = "cmd[update:1000] date +'%I:%M'";
          color = "rgba(${base0A}ee)";
          font_size = 96;
          position = "0, 300";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 3;
          shadow_color = "rgba(${base09}ee)";
        }
        { # Date
          text = "cmd[update:1000] date +'%A, %B %d %Y'";
          color = "rgba(${base0A}ee)";
          font_size = 22;
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 2;
          shadow_color = "rgba(${base09}ee)";
        }
      ];
    };
  };
}
