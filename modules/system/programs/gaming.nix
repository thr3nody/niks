{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mindustry-wayland
    mangohud
    protonup
    r2modman
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
}
