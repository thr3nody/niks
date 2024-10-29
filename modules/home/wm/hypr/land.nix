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
    ../components/mako.nix
    ../components/cliphist.nix
    ./paper.nix
    ./lock.nix
  ];

  home.packages = with pkgs; [
    sway-contrib.grimshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;
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
    settings = with config.colorScheme.palette; {
      "$mod" = "SUPER";
      "$supermod" = "SUPERSHIFT";
      "$menu" = "wofi --show drun --allow-image";

      bind =
        [
          "$mod, B, exec, firefox"
          "$mod, RETURN, exec, kitty"
          "$mod, S, exec, grimshot savecopy anything"
          "$mod, SPACE, exec, $menu"
          "$mod, M, exec, spotify"
          "$mod, P, exec, hyprpicker -a -f hex"
          "$mod, W, exec, pkill waybar || waybar &"
          "$mod, E, exec, nautilus"
          "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          "$mod, F, fullscreen"
          "$mod, Q, killactive"
          "$mod, A, togglefloating"

          "$mod, mouse_up, workspace, e+1"
          "$mod, mouse_down, workspace, e-1"

          "$supermod, Q, exit"
          "$supermod, L, exec, hyprlock"
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
        apply_sens_to_raw = 0; # Raw mouse input
      };

      input = {
        touchpad = {
          natural_scroll = true;
        };

        sensitivity = -0.6;
        accel_profile = "flat";
      };

      device = {
        name = "elan1203:00-04f3:307a-touchpad";
        sensitivity = 0.5;
      };

      decoration = {
        drop_shadow = true;
        shadow_range = 50;
        shadow_render_power = 3;
        "col.shadow" = "rgba(${base02}ee)";
        "col.shadow_inactive" = "rgba(${base00}ee)";
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
      windowrulev2 = workspace 3, class:(firefox)
      windowrulev2 = workspace 1, class:(Discord)
      windowrulev2 = float, class:(pavucontrol)
      windowrulev2 = size 622 652, class:(pavucontrol)


      exec-once = wl-paste --type text --watch cliphist store # Stores only text data
      exec-once = wl-paste --type image --watch cliphist store # Stores only image data
    '';
  };
}
