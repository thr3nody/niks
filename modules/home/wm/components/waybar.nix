{
  config,
  lib,
  ...
}: {
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

        modules-left =
          [
            "tray"
          ]
          ++ (lib.optionals
            config.wayland.windowManager.hyprland.enable [
              "hyprland/window"
            ]);
        modules-center =
          [
          ]
          ++ (lib.optionals
            config.wayland.windowManager.hyprland.enable [
              "hyprland/workspaces"
            ]);
        modules-right = [
          "backlight"
          "pulseaudio"
          "battery"
          "clock"
        ];

        # Left
        "hyprland/window" = {
          format = "{}";
          max-length = 20;
          rewrite = {"" = "Hyprland";};
          separate-outputs = true;
        };

        tray = {
          icon-size = 16;
          spacing = 8;
          show-passive-items = true;
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
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
        };

        # Right
        backlight = {
          format = "{icon} {percent}";
          format-icons = [" "];
        };

        pulseaudio = {
          format = "{icon}   {volume}";
          format-muted = "{}   {format_source}";
          format-icons = {
            headphone = " ";
            default = ["" " " " "];
          };
          on-click = "pavucontrol";
        };

        battery = {
          format = "{icon}   {capacity}";
          format-icons = [" " " " " " " " " "];
          format-charging = "    {capacity}";
          format-full = "{icon}";
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };

    style = let
      inherit (config.colorScheme) palette;
    in "
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
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
      #idle_inhibitor {
          padding:0.5rem 0.6rem;
          margin: 1px 0px;
      }

      #window {
        background-color: #${palette.base01};
        color: #${palette.base06};
        padding: 0.5rem 1rem;
        border-radius: 30px;
      }

      #tray {
        background-color: #${palette.base01};
        color: #${palette.base06};
        padding: 0.5rem 1rem;
        border-radius: 30px;
      }

      #tray menu {
        background-color: #${palette.base02};
        border-radius: 12px;
        color: #${palette.base06};
        padding: 0.5rem;
      }

      #workspaces {
        font-size: 13px;
      }

      #workspaces button {
        padding: 0.5rem 1rem;
        margin: 0 0.25rem;
        border-radius: 30px;
        background-color: #${palette.base01};
        color: #${palette.base06};
      }

      #workspaces button.active {
        padding: 0.5rem 2rem;
        transition-property: all;
        transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
        transition-duration: 150ms;
      }

      #workspaces button:hover {
        background-color: #${palette.base06};
        color: #${palette.base01};
      }

      #backlight {
        padding: 0.5rem 1rem;
        border-radius: 30px;
        background-color: #${palette.base01};
        color: #${palette.base06};
      }

      #pulseaudio {
        padding: 0.5rem 1rem;
        border-radius: 30px;
        background-color: #${palette.base01};
        color: #${palette.base06};
      }

      #pulseaudio.muted {
        background-color: #${palette.base09};
        color: #${palette.base01};
      }

      #pulseaudio.critical {
        background-color: #${palette.base08};
        color: #${palette.base01};
      }

      #battery {
        padding: 0.5rem 1rem;
        border-radius: 30px;
        background-color: #${palette.base01};
        color: #${palette.base06};
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.warning {
        color: #${palette.base09};
      }

      #battery.critical {
        color: #${palette.base08};
      }

      #battery.warning.discharging {
        color: #${palette.base09};
      }

      #battery.critical.discharging {
        color: #${palette.base08};
      }

      #battery.charging {
        background-color: #${palette.base0B};
        color: #${palette.base00};
      }

      #battery.full {
        background-color: #${palette.base06};
        color: #${palette.base01};
      }

      #clock {
        padding: 0.5rem 1rem;
        border-radius: 30px;
        background-color: #${palette.base01};
        color: #${palette.base06};
      }
    ";
  };
}
