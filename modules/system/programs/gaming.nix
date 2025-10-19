{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Install and launch games (no launcher)
    mindustry-wayland
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin

    # Utilities
    mangohud
    protonup

    # Modding
    r2modman # Outdated though, try gale
    gale

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
}
