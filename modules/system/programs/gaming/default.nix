{
  lib,
  config,
  ...
}: {
  options = {
    prog.steamy.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables gaming.";
    };
  };

  config = lib.mkIf config.prog.steamy.enable {
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
