{
  lib,
  config,
  ...
}: {
  options = {
    progs.steamy.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables gaming.";
    };
  };

  config = lib.mkIf config.progs.steamy.enable {
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
