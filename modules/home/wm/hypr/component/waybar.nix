{ config, lib, pkgs, ...}:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 5;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];

        modules-left = [

        ]
        ++ (lib.optionals
        config.wayland.windowManager.hyprland.enable [
          "hyprland/window"
        ]);
        modules-center = [

        ]
        ++ (lib.optionals
        config.wayland.windowManager.hyprland.enable [
          "hyprland/workspaces" 
        ]);
        modules-right = [
          "pulseaudio"
          "battery"
          "clock"
        ];

        # Left
        "hyprland/window" = {
          format = "{}";
          max-length = 35;
          rewrite = { "" = "Hyprland"; };
          separate-outputs = true;
        };

        # Center
        "hyprland/workspaces" = {
          format = "{icon}";
          all-outputs = true;
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
            default = " ";
          };
          presistent-workspaces = { "*" = [ 1 2 3 4 5 ]; };
        };

        # Right
        pulseaudio = {
          format = "{icon} {volume}"; 
          format-muted = "{} {format_source}";
          format-icons = {
            headphone = " ";
            default = [ "" " " " " ];
          };
          on-click = "pavucontrol";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = [" " " " " " " " " "];
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };
  };
}
