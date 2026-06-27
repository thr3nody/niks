{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.default

    # Truly modular (I guess...)
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

    initrd.luks.devices."cryptswap".device = "/dev/disk/by-uuid/468d034a-0b95-49cf-99a0-7f4a8e5e3274";

    kernelParams = [
      "mem_sleep_default=deep"
    ];
  };

  networking = {
    hostName = "europa";
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erine = {
    isNormalUser = true;
    description = "Erine Peregrine";
    extraGroups = ["networkmanager" "wheel" "docker" "kvm" "dialout"];
    packages = with pkgs; [
      signal-desktop
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
    daemonIOSchedClass = "idle";
    daemonCPUSchedPolicy = "idle";
    settings = {
      experimental-features = ["nix-command" "flakes"];
      cores = 4;
      max-jobs = 2;
    };
  };

  # Paket
  environment.systemPackages = with pkgs; [
    zathura
    mako
    motrix
    drawio

    pavucontrol

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
    aseprite

    # CLI/TUI
    wl-clipboard # Clipboard for Wayland
    zoxide # Better <cd>
    cbonsai # Bonsai tree
    yazi # File manager
    lm_sensors
    bunbun # VERY CUTE!
    peaclock # Clock
    inputs.curd.packages."${stdenv.hostPlatform.system}".default # Watch anime
    nurl # Generate nix fetcher url
    nix-tree # Interactively browse dependency graphs of Nix derivations
    nix-output-monitor
    fd

    # Coding Stuff
    python3

    vscode-langservers-extracted

    nodejs_22
    bun

    # Uh, gaming utilities
    mangohud
    protonup-ng
  ];

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

  # Stock Power Management
  powerManagement.enable = true;

  svcs = {
    actual.enable = true;
    auto-cpufreq.enable = true;
  };
  graphics = {
    opengl.enable = true;
    cpu = "amd";
    nvidia.vaapiEnable = false;
  };

  systemd.services.nix-daemon.serviceConfig = {
    Nice = lib.mkForce 15;
    CPUWeight = 5;
    CPUQuota = "70%";
    IOWeight = 5;
    MemoryHigh = "3072M";
    MemoryMax = "4096M";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
