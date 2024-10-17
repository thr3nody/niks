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
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [

        ]
        ++ (lib.optionals
        config.wayland.windowManager.hyprland.enable [
          "hyprland/workspaces"
        ]);
        modules-center = [ "sway/window" "custom/hello-from-waybar" ];
        modules-right = [ "battery" "clock" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };

        clock = {
          format-alt = ":%a, %d. %b  %H:%M";
        };

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
        };
      };
    };
  };
}
