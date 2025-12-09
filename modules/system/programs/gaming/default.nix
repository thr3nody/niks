{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options = {
    prog.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables gaming.";
    };
  };

  # TODO: Separate steamy gaming and other types of games.

  config = lib.mkIf config.prog.gaming.enable {
    environment.systemPackages = with pkgs; [
      # Install and launch games (no launcher)
      mindustry-wayland
      inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin

      # Utilities
      mangohud
      protonup-ng

      # Modding
      # gale #INFO: Broken in current update.

      # Non Steam
      bottles
      hydralauncher
      heroic
    ];

    programs = {
      # Steamy
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      # Gamemode
      gamemode.enable = true;
    };
  };
}
