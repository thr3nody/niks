{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mindustry-wayland
    mangohud
    protonup
    r2modman # Outdated though, try gale
    gale
    bottles
    hydralauncher
    heroic
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
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
