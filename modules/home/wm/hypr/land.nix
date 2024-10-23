{ pkgs, config, ... }:

{
  imports = [
    ./component/waybar.nix
    ./component/wofi.nix
    ./component/mako.nix
    ./themes/cursor.nix
    ./themes/gtk.nix
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
    settings = {
      "$mod" = "SUPER";
      "$supermod" = "SUPERSHIFT";
      "$menu" = "wofi --show drun --allow-image";

      bind =
        [
          "$mod, B, exec, firefox"
          "$mod, return, exec, kitty"
          "$mod, S, exec, grimshot copy anything"
          "$mod, F, fullscreen"
          "$mod, SPACE, exec, $menu"
          "$mod, M, exec, spotify"
        ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9)
      );

      general = with config.colorScheme.palette; {
        gaps_in = 6;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(${base09}ee)";
        "col.inactive_border" = "rgba(${base0C}ee)";
      };
    };
    extraConfig = ''
      monitor =,1920x1080@144,0x0,1

      input {
        touchpad {
          natural_scroll = true
        }
        sensitivity=-0.6
        accel_profile=flat
      }

      device {
        name=elan1203:00-04f3:307a-touchpad
        sensitivity=0.5
      }

      general {
        apply_sens_to_raw=0 # Raw mouse input
      }

      decoration {
        drop_shadow = true
        shadow_range=100
        shadow_render_power=5
        col.shadow= 0x33000000
        col.shadow_inactive=0x22000000
        rounding=15
      }

      animations {
        enabled=1
        bezier=overshot,0.13,0.99,0.29,1.1
        animation=windows,1,4,overshot,slide
        animation=border,1,10,default
        animation=fade,1,10,default
        animation=workspaces,1,6,overshot,slidevert
      }

      dwindle {
        pseudotile=1 # enable pseudotiling on dwindle
        force_split=0
      }

      master{
          
      }

      gestures {
        workspace_swipe=yes
        workspace_swipe_fingers=4
      }

      # example window rules
      # for windows named/classed as abc and xyz
      #windowrule=move 69 420,abc
      windowrule=move center,title:^(fly_is_kitty)$
      windowrule=size 800 500,title:^(fly_is_kitty)$
      windowrule=animation slide,title:^(all_is_kitty)$
      windowrule=float,title:^(all_is_kitty)$
      #windowrule=tile,xy
      windowrule=tile,title:^(kitty)$
      windowrule=float,title:^(fly_is_kitty)$
      windowrule=float,title:^(clock_is_kitty)$
      windowrule=size 418 234,title:^(clock_is_kitty)$
      #windowrule=pseudo,abc
      #windowrule=monitor 0,xyz

      bind=SUPER,Q,killactive
      bind=SUPERSHIFT,Q,exit

      bind=SUPERSHIFT,L,exec,hyprlock
    '';
  };
}
