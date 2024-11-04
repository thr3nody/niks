{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ../../modules/system/wm/hypr.nix
    ../../modules/system/dm/greetd.nix
    ../../modules/system/audio/pulse.nix
    ../../modules/system/audio/pipewire.nix
    ../../modules/system/securities/pam.nix
    ../../modules/system/networking/firewall.nix
    ../../modules/system/networking/tailscale.nix
    ../../modules/system/themes/fonts.nix
    ../../modules/system/de/gnome.nix
    ../../modules/system/services/tor.nix
    ../../modules/system/graphics/opengl.nix
    ../../modules/system/graphics/nvidia/535.nix
  ];

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices."luks-9addd389-4e0e-408d-be35-702214e2f5de".device = "/dev/disk/by-uuid/9addd389-4e0e-408d-be35-702214e2f5de";
  };

  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the X11 windowing system.
  services = {
    xserver.enable = true;
    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    printing.enable = true;
  };

  # RTKit
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Experimental
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Xbox Gamepad
  # hardware.xone.enable = true;
  hardware.xpadneo.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erine = {
    isNormalUser = true;
    description = "Erine Moira";
    extraGroups = ["networkmanager" "wheel" "docker" "kvm" "adbuser"];
    packages = with pkgs; [
      thunderbird
      vesktop
      element-desktop
      spotify-player # TUI for Spotify
      telegram-desktop
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "erine" = import ./home.nix;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "Sat *-*-* 20:30:00";
  };
  nix.optimise = {
    automatic = true;
    dates = ["Sat *-*-* 21:00:00"];
  };

  # Paket
  environment.systemPackages = with pkgs; [
    motrix
    feh
    gimp
    krita
    audacity
    libreoffice-still
    zathura
    chromium

    # Video thing
    flowblade
    kdenlive
    mpv
    vlc

    # Bottles(?)
    wineWowPackages.stable
    winetricks
    bottles

    # Ngegame bentaran lah ya
    mindustry-wayland
    mangohud
    protonup

    # Godot
    godot_4

    # Terminal Emulator
    kitty

    # Cli
    git
    fzf
    grc
    btop
    fd
    ripgrep
    xclip # Clipboard for X
    wl-clipboard # Clipboard for Wayland
    wget
    starship
    zoxide
    cbonsai
    yazi # File manager
    lm_sensors
    bunbun # VERY CUTE!
    unrar

    # Coding Stuff
    lunarvim
    vscode
    zed-editor
    android-studio

    gitlab-runner

    php
    php82Packages.composer

    nodejs_22
    nodePackages.eslint

    bun

    luajitPackages.luarocks

    python3

    zulu

    vscode-langservers-extracted

    # Docker Compose
    docker-compose

    # LaTex
    texliveFull
    texlab

    # Fish Plugins
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.grc
    fishPlugins.colored-man-pages
    fishPlugins.autopair

    # Cloudflare
    cloudflare-warp
  ];

  # Adb
  programs.adb.enable = true;

  # Steamy
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Virt Manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  # Chromium
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"
    ];
  };

  # Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
      zoxide init fish | source
      set fish_greeting
      alias blade="GDK_BACKEND=x11 SDL_VIDEODRIVER=x11 nvidia-offload flowblade"
      bunbun
    '';
  };

  # Bash
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # Autostart warp-svc on startup.
  systemd.packages = [pkgs.cloudflare-warp];
  systemd.targets.multi-user.wants = ["warp-svc.service"];

  # Polkit
  security.polkit.enable = true;

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
