{ ... }:

{
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
      bind=SUPER,return,exec,kitty
      bind=SUPER,Q,killactive
      bind=SUPERSHIFT,Q,exit
    '';
  };
}
