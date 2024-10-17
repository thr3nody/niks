{ ... }:

{
  imports = [
    ./component/waybar.nix
    ./paper.nix
    ./lock.nix
    ../../wofi.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind =
        [
          # "$mod, F, exec, ${pkgs.firefox}"
          # "$mod, return, exec, ${pkgs.kitty}"
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

      general {
        gaps_in=6
        gaps_out=10
        border_size=3
        col.active_border=rgba(cba6f7ff) rgba(89b4faff) rgba(94e2d5ff) 10deg
        col.inactive_border=0xff45475a
        apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        # col.group_border=0xff89dceb
        # col.group_border_active=0xfff9e2af
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
        # bezier=overshot,0.05,0.9,0.1,1.1
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

      bind=SUPER,return,exec,kitty
      bind=SUPER,Q,killactive
      bind=SUPERSHIFT,Q,exit
      bind=SUPER,B,exec,firefox
      
      $menu = wofi --show drun

      bind=SUPER,S,exec,$menu

      bind=SUPERSHIFT,L,exec,hyprlock
    '';
  };
}
