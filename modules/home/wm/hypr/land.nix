{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../themes/cursor.nix
    ../../themes/gtk.nix

    ../components/waybar.nix
    ../components/tofi/default.nix
    ../components/mako.nix
    ../components/swayosd.nix

    ../../services/gnome-keyring.nix

    ./paper.nix
    ./lock.nix
  ];

  home.packages = with pkgs; [
    grimblast
    libnotify
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = with config.colorScheme.palette; {
      "$mod" = "SUPER";
      "$supermod" = "SUPERSHIFT";

      "$menu" = "tofi-run | xargs hyprctl dispatch exec --";
      "$bar" = "pkill waybar || waybar &";
      "$clipboard" = "kitty --class clipse -e clipse";
      "$color-picker-hex" = "hyprpicker -a -f hex";
      "$color-picker-rgb" = "hyprpicker -a -f rgb";
      "$clock" = "pkill peaclock || kitty --class peaclock -e peaclock";
      "$screenshot" = "grimblast --notify copysave area \"./Pictures/Screenshots/$(date +'%Y-%m-%d %H:%M:%S').png\"";
      "$screenshot-full" = "grimblast --notify copysave screen \"./Pictures/Screenshots/$(date +'%Y-%m-%d %H:%M:%S').png\"";

      bind =
        [
          "$supermod, B, exec, nvidia-offload zen"
          "$supermod, D, exec, legcord"
          "$supermod, RETURN, exec, kitty --class secretty"
          "$supermod, P, exec, $color-picker-rgb"

          "$mod, B, exec, zen"
          "$mod, D, exec, vesktop"
          "$mod, T, exec, thunderbird"
          "$mod, RETURN, exec, kitty"
          "$mod, SPACE, exec, $menu"
          "$mod, M, exec, kitty --class moosic -e musikcube"
          "$mod, P, exec, $color-picker-hex"
          "$mod, W, exec, $bar"
          "$mod, E, exec, Thunar"
          "$mod, V, exec, $clipboard"
          "$mod, C, exec, $clock"

          "$mod, F, fullscreen"
          "$mod, Q, killactive"
          "$mod, A, togglefloating"

          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          "$supermod, H, movewindow, l"
          "$supermod, L, movewindow, r"
          "$supermod, K, movewindow, u"
          "$supermod, J, movewindow, d"

          "$mod, mouse_up, workspace, e+1"
          "$mod, mouse_down, workspace, e-1"

          "$supermod, Q, exec, uwsm stop"
          "$supermod, BACKSPACE, exec, hyprlock"

          "$mod, 0, workspace, 10"
          "$supermod, 0, movetoworkspace, 10"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      bindl = [
        "$mod, S, exec, $screenshot"
        "$supermod, S, exec, $screenshot-full"
        ", PRINT, exec, $screenshot-full"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"

        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"

        ", Caps_Lock, exec, sleep 0.07; swayosd-client --caps-lock"
        ", Num_Lock, exec, sleep 0.07; swayosd-client --num-lock"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      monitor = [
        "eDP-1,1920x1080@144,0x0,1"
        "HDMI-A-1,1920x1080@60,auto,1,mirror,eDP-1"
      ];

      general = {
        gaps_in = 6;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(${base09}ee)";
        "col.inactive_border" = "rgba(${base02}ee)";
      };

      input = {
        kb_options = "compose:ralt";

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.4;
        };

        sensitivity = -0.6;
        accel_profile = "flat";
      };

      device = {
        name = "elan1203:00-04f3:307a-touchpad";
        sensitivity = 0.5;
      };

      decoration = {
        shadow = {
          enabled = true;
          render_power = 3;
          color = "rgba(${base02}ee)";
          color_inactive = "rgba(${base00}ee)";
          range = 50;
        };
        rounding = 15;
        blur = {
          enabled = true;
          size = 8;
          passes = 4;
          new_optimizations = true;
          ignore_opacity = true;
        };
      };

      dwindle = {
        pseudotile = 1; # Enable pseudotiling on dwindle
        force_split = 0;
      };
    };

    extraConfig = ''
      animations {
        enabled=1
        bezier=overshot,0.13,0.99,0.29,1.1
        animation=windows,1,4,overshot,slide
        animation=border,1,10,default
        animation=fade,1,10,default
        animation=workspaces,1,6,overshot,slidevert
      }

      windowrule = workspace 5, match:class moosic
      windowrule = workspace 4, match:class Code
      windowrule = workspace 4, match:class dev.zed.Zed
      windowrule = workspace 4, match:class Godot_Engine
      windowrule = workspace 3, match:class firefox
      windowrule = workspace 3, match:class zen
      windowrule = workspace 3, match:class zen-beta
      windowrule = workspace 3, match:class zen-twilight
      windowrule = workspace 1, match:class legcord
      windowrule = workspace 1, match:class discord
      windowrule = workspace 1, match:class vesktop

      windowrule = float on, match:class org.pulseaudio.pavucontrol
      windowrule = size 622 652, match:class org.pulseaudio.pavucontrol
      windowrule = float on, match:class clipse
      windowrule = size 622 652, match:class clipse
      windowrule = float on, match:class peaclock
      windowrule = size 360 230, match:class peaclock

      windowrule = no_screen_share on, match:class vesktop
      windowrule = no_screen_share on, match:class discord
      windowrule = no_screen_share on, match:class legcord
      windowrule = no_screen_share on, match:class Thunar
      windowrule = no_screen_share on, match:class org.gnome.seahorse.Application
      windowrule = no_screen_share on, match:class thunderbird
      windowrule = no_screen_share on, match:class secretty
      windowrule = no_screen_share on, match:class clipse

      windowrule = no_screen_share on, match:title .*[Ww]hats[Aa]pp.*
      windowrule = no_screen_share on, match:title .*[Bb]itwarden.*

      layerrule = no_screen_share on, match:namespace notifications

      exec-once = clipse -listen

      cursor {
        no_hardware_cursors = false
      }

      gesture = 3, vertical, workspace
    '';
  };
}
