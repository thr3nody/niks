{
  pkgs,
  lib,
  config,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
in {
  options = {
    dm.greetd.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables greetd with tuigreet.";
    };
  };

  config = lib.mkIf config.dm.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember";
          user = "greeter";
        };
      };
    };

    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
