{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.default

    # Truly modular
    ../../modules/system/audio/default.nix
    ../../modules/system/dm/default.nix
    ../../modules/system/networking/default.nix
    ../../modules/system/wm/default.nix
    ../../modules/system/graphics/default.nix
    ../../modules/system/services/default.nix
    ../../modules/system/programs/default.nix

    # Not truly modular
    # On purpose (I'm lazy mate)
    ../../modules/system/securities/pam.nix
    ../../modules/system/themes/fonts.nix
  ];

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices."luks-9addd389-4e0e-408d-be35-702214e2f5de".device = "/dev/disk/by-uuid/9addd389-4e0e-408d-be35-702214e2f5de";
    kernelParams = ["module_blacklist=mt7921e"];
  };

  networking = {
    hostName = "nixos";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "id_ID.UTF-8";
      LC_IDENTIFICATION = "id_ID.UTF-8";
      LC_MEASUREMENT = "id_ID.UTF-8";
      LC_MONETARY = "id_ID.UTF-8";
      LC_NAME = "id_ID.UTF-8";
      LC_NUMERIC = "id_ID.UTF-8";
      LC_PAPER = "id_ID.UTF-8";
      LC_TELEPHONE = "id_ID.UTF-8";
      LC_TIME = "id_ID.UTF-8";
    };
  };

  # RTKit
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  hardware = {
    # Xbox Gamepad
    xone.enable = true;
    # xpadneo.enable = true;

    # Drawing Tablet
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
      blacklistedKernelModules = [
        # Just some examples from the docs.
        "hid-uclogic"
        "wacom"
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erine = {
    isNormalUser = true;
    description = "Erine Moira";
    extraGroups = ["networkmanager" "wheel" "docker" "kvm" "adbuser" "dialout"];
    packages = with pkgs; [
      spotify-player # TUI for Spotify
      kew # Music player
      vesktop
      (discord.override {
        withOpenASAR = true;
      })
    ];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "erine" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      trusted-users = root erine
    '';
    settings = {
      experimental-features = ["nix-command" "flakes"];
      cores = 4;
      max-jobs = 2;
    };
    # Garbage Collection
    gc = {
      automatic = true;
      dates = "Sat *-*-* 20:30:00";
    };
    optimise = {
      automatic = true;
      dates = ["Sat *-*-* 21:00:00"];
    };
  };

  # Paket
  environment.systemPackages = with pkgs; [
    # audacity # INFO: Build failed in current update.
    zathura
    supergfxctl
    mako
    motrix
    drawio

    pavucontrol
    helvum

    # Input test thingy
    evtest
    wev

    # Keyring and stuff
    gnome-keyring
    gcr

    # Productivity, I guess
    libreoffice-fresh
    obsidian
    obsidian-export

    # Image things
    feh
    gimp3-with-plugins
    krita
    inkscape
    aseprite

    # Browser
    brave

    # Video thing
    kdePackages.kdenlive
    vlc

    # CLI/TUI
    fzf
    fd
    ripgrep
    wl-clipboard # Clipboard for Wayland
    clipse # TUI Clipboard Manager
    wget
    zoxide # Better <cd>
    cbonsai # Bonsai tree
    yazi # File manager
    lm_sensors
    bunbun # VERY CUTE!
    unrar
    peaclock # Clock
    cava # Audio Visualizer
    inputs.curd.packages."${stdenv.hostPlatform.system}".default # Watch anime
    nix-output-monitor # As the name would suggest
    nurl # Generate nix fetcher url
    nix-tree # Interactively browse dependency graphs of Nix derivations

    # Coding Stuff
    devenv

    vscode
    thonny

    php
    php82Packages.composer

    dotnet-sdk
    omnisharp-roslyn

    nodejs_22

    bun
    deno

    python3

    vscode-langservers-extracted
  ];

  # Adb
  programs.adb.enable = true;

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  # Polkit
  security.polkit.enable = true;

  netSetup.protonvpn.enable = true;
  svcs.tailscale.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    Nice = lib.mkForce 15;
    CPUWeight = 5;
    IOSchedulingClass = lib.mkForce "idle";
    IOSchedulingPriority = lib.mkForce 7;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
