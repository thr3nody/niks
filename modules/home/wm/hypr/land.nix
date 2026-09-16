{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ../../themes/cursor.nix
    ../../themes/gtk.nix

    ../components/quickshell/default.nix
    ../components/tofi/default.nix
    ../components/mako.nix
    ../components/swayosd.nix

    ../../services/gnome-keyring.nix

    ./paper.nix
    ./lock.nix
  ];

  options.wm.hyprland = {
    monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [];
      description = "Monitor config blocks.";
    };

    devices = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [];
      description = "Hyprland per-device config block.";
    };

    mouseSens = lib.mkOption {
      type = lib.types.float;
      default = -0.6;
      description = "Global mouse sensitivity.";
    };

    touchpadScrollFactor = lib.mkOption {
      type = lib.types.float;
      default = 0.4;
      description = "Global touchpad scroll factor.";
    };

    extraBinds = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra keybind entries.";
    };

    extraExecOnce = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra exec-once entries.";
    };
  };

  config = {
    home.packages = with pkgs; [
      grimblast
      libnotify
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd.enable = false;
      settings = with config.colorScheme.palette; {
        bind = let
          lua = lib.generators.mkLuaInline;
          mkBind = args: {_args = args;};
          bind = key: action:
            mkBind [
              key
              (lua action)
            ];
          bindWithFlags = key: action: flags:
            mkBind [
              key
              (lua action)
              flags
            ];
          exec = cmd: ''hl.dsp.exec_cmd([[${cmd}]])'';
          mvToWs = ws: ''hl.dsp.focus({ workspace = "${ws}"})'';
          mvWinToWs = ws: ''hl.dsp.window.move({ workspace = "${ws}"})'';
          mvWinTo = dr: ''hl.dsp.window.move({ direction = "${dr}"})'';
          mvFocusTo = dr: ''hl.dsp.focus({ direction = "${dr}"})'';
          fullScreenMode = mode: ''hl.dsp.window.fullscreen({ mode = "${mode}"})'';
        in [
          (bind "SUPER + SPACE" (exec "tofi-run | xargs hyprctl dispatch exec --"))

          # Workspace
          (bind "SUPER + 1" (mvToWs "1"))
          (bind "SUPER + 2" (mvToWs "2"))
          (bind "SUPER + 3" (mvToWs "3"))
          (bind "SUPER + 4" (mvToWs "4"))
          (bind "SUPER + 5" (mvToWs "5"))
          (bind "SUPER + 6" (mvToWs "6"))
          (bind "SUPER + 7" (mvToWs "7"))
          (bind "SUPER + 8" (mvToWs "8"))
          (bind "SUPER + 9" (mvToWs "9"))
          (bind "SUPER + 0" (mvToWs "10"))

          (bind "SUPER + SHIFT + 1" (mvWinToWs "1"))
          (bind "SUPER + SHIFT + 2" (mvWinToWs "2"))
          (bind "SUPER + SHIFT + 3" (mvWinToWs "3"))
          (bind "SUPER + SHIFT + 4" (mvWinToWs "4"))
          (bind "SUPER + SHIFT + 5" (mvWinToWs "5"))
          (bind "SUPER + SHIFT + 6" (mvWinToWs "6"))
          (bind "SUPER + SHIFT + 7" (mvWinToWs "7"))
          (bind "SUPER + SHIFT + 8" (mvWinToWs "8"))
          (bind "SUPER + SHIFT + 9" (mvWinToWs "9"))
          (bind "SUPER + SHIFT + 0" (mvWinToWs "10"))

          (bindWithFlags "SUPER + mouse_up" "hl.dsp.focus({ workspace = \"e+1\"})" {mouse = true;})
          (bindWithFlags "SUPER + mouse_down" "hl.dsp.focus({ workspace = \"e-1\"})" {mouse = true;})

          # Window
          (bind "SUPER + H" (mvFocusTo "left"))
          (bind "SUPER + L" (mvFocusTo "right"))
          (bind "SUPER + K" (mvFocusTo "up"))
          (bind "SUPER + J" (mvFocusTo "down"))

          (bind "SUPER + SHIFT + H" (mvWinTo "left"))
          (bind "SUPER + SHIFT + L" (mvWinTo "right"))
          (bind "SUPER + SHIFT + K" (mvWinTo "up"))
          (bind "SUPER + SHIFT + J" (mvWinTo "down"))

          (bind "SUPER + Q" "hl.dsp.window.close()")

          (bind "SUPER + F" (fullScreenMode "maximized"))
          (bind "SUPER + F11" (fullScreenMode "fullscreen"))
          (bind "SUPER + A" "hl.dsp.window.float()")

          (bindWithFlags "SUPER + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
          (bindWithFlags "SUPER + mouse:273" "hl.dsp.window.resize()" {mouse = true;})

          # Apps
          (bind "SUPER + RETURN" (exec "kitty"))
          (bind "SUPER + SHIFT + RETURN" (exec "kitty --class secretty"))

          (bind "SUPER + B" (exec "zen-beta"))
          (bind "SUPER + D" (exec "signal-desktop"))
          (bind "SUPER + T" (exec "thunderbird"))
          (bind "SUPER + M" (exec "kitty --class moosic -e musikcube"))
          (bind "SUPER + P" (exec "hyprpicker -a -f hex"))
          (bind "SUPER + SHIFT + P" (exec "hyprpicker -a -f rgb"))
          (bind "SUPER + E" (exec "thunar"))
          (bind "SUPER + V" (exec "kitty --class clipse -e clipse"))
          (bind "SUPER + C" (exec "pkill peaclock || kitty --class peaclock -e peaclock"))

          # Other stuff
          (bind "SUPER + SHIFT + Q" (exec "uwsm stop"))
          (bind "SUPER + SHIFT + BACKSPACE" (exec "hyprlock"))

          (bindWithFlags "SUPER + S" (exec "grimblast --notify copysave area \"./Pictures/Screenshots/$(date +'%Y-%m-%d %H:%M:%S').png\"") {locked = true;})
          (bindWithFlags "SUPER + SHIFT + S" (exec "grimblast --notify copysave screen \"./Pictures/Screenshots/$(date +'%Y-%m-%d %H:%M:%S').png\"") {locked = true;})
          (bindWithFlags "PRINT" (exec "grimblast --notify copysave screen \"./Pictures/Screenshots/$(date +'%Y-%m-%d %H:%M:%S').png\"") {locked = true;})

          (bindWithFlags "XF86AudioRaiseVolume" (exec "swayosd-client --output-volume raise") {repeat = true;})
          (bindWithFlags "XF86AudioLowerVolume" (exec "swayosd-client --output-volume lower") {repeat = true;})

          (bind "XF86AudioMute" (exec "sleep 0.07; swayosd-client --output-volume mute-toggle"))
          (bind "XF86AudioMicMute" (exec "sleep 0.07; swayosd-client --input-volume mute-toggle"))

          (bindWithFlags "XF86MonBrightnessUp" (exec "swayosd-client --brightness raise") {repeat = true;})
          (bindWithFlags "XF86MonBrightnessDown" (exec "swayosd-client --brightness lower") {repeat = true;})

          (bind "Caps_Lock" (exec "sleep 0.07; swayosd-client --caps-lock"))
          (bind "Num_Lock" (exec "sleep 0.07; swayosd-client --num-lock"))
        ];

        monitor = config.wm.hyprland.monitors;

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
            scroll_factor = config.wm.hyprland.touchpadScrollFactor;
          };

          sensitivity = config.wm.hyprland.mouseSens;
          accel_profile = "flat";
        };

        device = config.wm.hyprland.devices;

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

        dwindle.force_split = 0;

        # TODO: These might need reworks. But should be ok.
        # https://wiki.hypr.land/configuring/core/animations/
        animations = {
          enabled = 1;
          bezier = ["overshot,0.13,0.99,0.29,1.1"];
          animation = [
            "windows,1,4,overshot,slide"
            "border,1,10,default"
            "fade,1,10,default"
            "workspaces,1,6,overshot,slidevert"
          ];
        };

        window_rule = [
          {
            match.class = "moosic";
            workspace = "5";
          }
          {
            match.class = "zen-beta";
            workspace = "3";
          }

          {
            match.class = "vesktop";
            workspace = "1";
            no_screen_share = true;
          }
          {
            match.class = "signal";
            workspace = "1";
            no_screen_share = true;
          }

          {
            match.class = "org.pulseaudio.pavucontrol";
            float = true;
            size = [622 652];
          }
          {
            match.class = "clipse";
            float = true;
            size = [622 652];
          }
          {
            match.class = "peaclock";
            float = true;
            size = [360 230];
          }

          {
            match.class = "Thunar";
            no_screen_share = true;
          }
          {
            match.class = "org.gnome.seahorse.Application";
            no_screen_share = true;
          }
          {
            match.class = "secretty";
            no_screen_share = true;
          }
          {
            match.class = "clipse";
            no_screen_share = true;
          }
          {
            match.title = ".*[Ww]hats[Aa]pp.*";
            no_screen_share = true;
          }
          {
            match.title = ".*[Bb]itwarden.*";
            no_screen_share = true;
          }
          {
            match.title = ".*[Gg]mail.*";
            no_screen_share = true;
          }
        ];

        layer_rule = [
          {
            match.namespace = "notifications";
            no_screen_share = true;
          }
        ];

        cursor.no_hardware_cursors = 0;

        # TODO: Might have to rework this for config.wm.hyprland.extraExecOnce option.
        on = let
          lua = lib.generators.mkLuaInline;
          on = event: body: {
            _args = [
              event
              (lua ''function() ${body} end'')
            ];
          };
          exec = cmd: ''hl.exec_cmd("${cmd}")'';
        in [
          (on "hyprland.start" ''
            ${exec "clipse -listen"}
          '')
        ];
      };
    };
  };
}
