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
    ../../modules/home/programs/ghostty/default.nix
    ../../modules/home/programs/kitty/default.nix
    ../../modules/home/programs/obs/default.nix
    ../../modules/home/programs/librewolf/default.nix
    ../../modules/home/programs/mpv/default.nix.nix

    ../../modules/home/themes/spicetify.nix

    ../../modules/home/shell/nushell.nix

    ../../modules/home/services/easyeffects.nix
  ];

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
  # base0F: #d65d0e

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "erine";
    homeDirectory = "/home/erine";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Gnome GTK4 set all to dark theme.
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/erine/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
