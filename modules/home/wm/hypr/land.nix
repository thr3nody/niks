{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../../themes/cursor.nix
    ../../themes/gtk.nix
    ../components/waybar.nix
    ../components/wofi.nix
    ../components/tofi/default.nix
    ../components/mako.nix
    ./paper.nix
    ./lock.nix
  ];

  home.packages = with pkgs; [
    sway-contrib.grimshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = with config.colorScheme.palette; {
      "$mod" = "SUPER";
      "$supermod" = "SUPERSHIFT";
      "$menu" = "wofi --show drun --allow-image";
      "$clipboard" = "kitty --class clipse -e clipse";
      "$screenshot" = "grimshot savecopy anything \"./Pictures/Screenshots/$(date +'%Y-%m-%d %H:%M:%S').png\"";

      bind =
        [
          "$mod, B, exec, zen"
          "$mod, D, exec, vesktop"
          "$mod, RETURN, exec, kitty"
          "$mod, S, exec, $screenshot"
          "$mod, SPACE, exec, $menu"
          "$mod, M, exec, spotify"
          "$mod, P, exec, hyprpicker -a -f hex"
          "$mod, W, exec, pkill waybar || waybar &"
          "$mod, E, exec, nautilus"
          "$mod, V, exec, $clipboard"

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

          "$supermod, Q, exit"
          "$supermod, BACKSPACE, exec, hyprlock"
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

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      gestures = {
        workspace_swipe = "yes";
        workspace_swipe_fingers = 3;
      };

      monitor = ",1920x1080@144,0x0,1";

      general = {
        gaps_in = 6;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(${base09}ee)";
        "col.inactive_border" = "rgba(${base02}ee)";
      };

      input = {
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
      windowrulev2 = workspace 3, class:(zen-beta)
      windowrulev2 = workspace 1, class:(vesktop)
      windowrulev2 = float, class:(org.pulseaudio.pavucontrol)
      windowrulev2 = size 622 652, class:(org.pulseaudio.pavucontrol)
      windowrulev2 = float, class:(clipse)
      windowrulev2 = size 622 652, class:(clipse)

      exec-once = clipse -listen
      exec-once = hyprctl setcursor Pokemon 24
    '';
  };
}
