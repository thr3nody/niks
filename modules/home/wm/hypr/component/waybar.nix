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

    style = let
      inherit (config.colorScheme) colors;
    in
    "
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 1px;
        padding: 0;
      }

      #waybar {
        background: transparent;
        font-size: 13px;
        font-weight: bold;
        transition-property: all;
        transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        transition-duration: 150ms;
      }

      #battery,
      #clock,
      #backlight,
      #cpu,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray,
      #idle_inhibitor {
          padding:0.5rem 0.6rem;
          margin: 1px 0px;
      }

      #window {
        background-color: #${colors.base01};
        color: #${colors.base06};
        padding: 0.5rem 1rem;
        border-radius: 25px;
        transition-property: all;
        transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        transition-duration: 150ms;
      }

      #workspaces {
        font-size: 13px;
        transition-property: all;
        transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        transition-duration: 150ms;
      }

      #workspaces button {
        padding: 0.5rem 1rem;
        background-color: #${colors.base01};
        color: #${colors.base06};
        border-radius: 25px;
      }

      #workspaces button.active {
        padding: 0.5rem 2rem;
      }

      #workspaces button:hover {
        background-color: #${colors.base06};
        color: #${colors.base01};
      }

      #pulseaudio {
      }

      #pulseaudio.muted {
        color: #${colors.base0A};
      }

      #pulseaudio.critical {
        color: #${colors.base08};
      }

      #battery {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.warning {
          color: #${colors.base09};
      }

      #battery.critical {
          color: #${colors.base08};
      }

      #battery.warning.discharging {
          color: #${colors.base09};
      }

      #battery.critical.discharging {
          color: #${colors.base08};
      }
    ";
  };
}
