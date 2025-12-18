{config, ...}: {
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
          path = "$HOME/Pictures/Walp/hyprlock/bg.jpg";
          brightness = 0.7;
          contrast = 0.8;
        }
        {
          path = "$HOME/Pictures/Walp/hyprlock/fg.png";
          monitor = "";
          zindex = 1;
          keep_aspect_ratio = true;
          rounding = 0;
          border_size = 0;
          brightness = 0.7;
          contrast = 0.8;
        }
      ];

      label = [
        {
          # Time
          text = "cmd[update:1000] date +'%H'";
          color = "rgba(${base0A}ee)";
          font_size = 200;
          font_family = "Nacelle Heavy";
          position = "0, 60";
          halign = "center";
          valign = "center";
        }
        {
          # Time
          text = "cmd[update:1000] date +'%M'";
          color = "rgba(${base0A}ee)";
          font_size = 200;
          font_family = "Nacelle Heavy";
          position = "0, -165";
          halign = "center";
          valign = "center";
        }
        {
          # Date
          text = "cmd[update:1000] date +'%A, %B %d %Y'";
          color = "rgba(${base0A}ee)";
          font_size = 16;
          font_family = "Nacelle Light";
          position = "0, 500";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "256, 48";
          rounding = 1;
          position = "0, -500";
          zindex = 1;
          monitor = "";
          dots_center = true;
          dots_size = 0.3;
          dots_spacing = 0.15;
          dots_text_format = "😘";
          fade_on_empty = true;
          font_color = "rgba(${base0A}ee)";
          inner_color = "rgba(${base03}ee)";
          outer_color = "rgba(${base0A}ee)";
          outline_thickness = 2;
          placeholder_text = "<i>Input Password :3</i>";
          fail_text = "<i>You failed OwO</i>";
          check_color = "rgba(${base06}ee)";
          fail_color = "rgba(${base08}ee)";
        }
      ];
    };
  };
}
