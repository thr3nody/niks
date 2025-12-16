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
          "$mod, M, exec, spotify"
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

      windowrulev2 = workspace 5, class:(Spotify)
      windowrulev2 = workspace 4, class:(Code)
      windowrulev2 = workspace 4, class:(dev.zed.Zed)
      windowrulev2 = workspace 4, class:(Godot_Engine)
      windowrulev2 = workspace 3, class:(firefox)
      windowrulev2 = workspace 3, class:(zen)
      windowrulev2 = workspace 3, class:(zen-beta)
      windowrulev2 = workspace 3, class:(zen-twilight)
      windowrulev2 = workspace 1, class:(legcord)
      windowrulev2 = workspace 1, class:(discord)
      windowrulev2 = workspace 1, class:(vesktop)

      windowrulev2 = float, class:(org.pulseaudio.pavucontrol)
      windowrulev2 = size 622 652, class:(org.pulseaudio.pavucontrol)
      windowrulev2 = float, class:(clipse)
      windowrulev2 = size 622 652, class:(clipse)
      windowrulev2 = float, class:(peaclock)
      windowrulev2 = size 360 230, class:(peaclock)

      windowrulev2 = noscreenshare, class:(vesktop)
      windowrulev2 = noscreenshare, class:(discord)
      windowrulev2 = noscreenshare, class:(legcord)
      windowrulev2 = noscreenshare, class:(Thunar)
      windowrulev2 = noscreenshare, class:(org.gnome.seahorse.Application)
      windowrulev2 = noscreenshare, class:(thunderbird)
      windowrulev2 = noscreenshare, class:(secretty)
      windowrulev2 = noscreenshare, class:(clipse)

      windowrulev2 = noscreenshare, title:(WhatsApp — Zen Browser)
      windowrulev2 = noscreenshare, title:(.*[Bb]itwarden.*)

      layerrule = noscreenshare, notifications

      exec-once = clipse -listen

      cursor {
        no_hardware_cursors = false
      }

      gesture = 3, vertical, workspace
    '';
  };
}
