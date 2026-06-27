{inputs, ...}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/home/wm/hypr/land.nix

    ../../modules/home/programs/nixvim/default.nix
    ../../modules/home/programs/git/default.nix
    ../../modules/home/programs/lazygit/default.nix
    ../../modules/home/programs/carapace/default.nix
    ../../modules/home/programs/starship/default.nix
    ../../modules/home/programs/zoxide/default.nix
    ../../modules/home/programs/kitty/default.nix
    ../../modules/home/programs/zen-browser/default.nix
    ../../modules/home/programs/mpv/default.nix
    ../../modules/home/programs/btop/default.nix
    ../../modules/home/programs/clipse/default.nix

    ../../modules/home/shell/nushell.nix

    ../../modules/home/services/easyeffects.nix
  ];

  # eropa machine

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  nixpkgs.config.allowUnfree = true;
  # system: base16
  # slug: gruvbox-dark-medium
  # name: Gruvbox dark, medium
  # author: Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
  # variant: dark
  # palette:
  #   base00: #282828
  #   base01: #3c3836
  #   base02: #504945
  #   base03: #665c54
  #   base04: #bdae93
  #   base05: #d5c4a1
  #   base06: #ebdbb2
  #   base07: #fbf1c7
  #   base08: #fb4934
  #   base09: #fe8019
  #   base0A: #fabd2f
  #   base0B: #b8bb26
  #   base0C: #8ec07c
  #   base0D: #83a598
  #   base0E: #d3869b
  #   base0F: #d65d0e

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "erine";
    homeDirectory = "/home/erine";
  };

  wm.hyprland = {
    monitors = ["eDP-1,1920x1080@60,0x0,1"];
    mouseSens = -0.6;
    touchpadScrollFactor = 0.15;
    devices = [
      {
        name = "synps/2-synaptics-touchpad";
        sensitivity = 0.3;
      }
    ];
  };

  # Gnome GTK4 set all to dark theme.
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
