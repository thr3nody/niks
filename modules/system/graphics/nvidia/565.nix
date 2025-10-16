{config, ...}: {
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # Needed for suspend to behave correctly.
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "565.57.01";
      sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
      sha256_aarch64 = "sha256-aDVc3sNTG4O3y+vKW87mw+i9AqXCY29GVqEIUlsvYfE=";
      openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
      settingsSha256 = "sha256-H7uEe34LdmUFcMcS6bz7sbpYhg9zPCb/5AmZZFTx1QA=";
      persistencedSha256 = "sha256-hdszsACWNqkCh8G4VBNitDT85gk9gJe1BlQ8LdrYIkg=";
    };
    open = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # environment.variables = {
  #   # Stolen from https://github.com/TLATER/dotfiles/blob/f4ed53e9e78ff41cd2849f389499d3bfd3ffe4c7/nixos-config/hosts/yui/nvidia/default.nix
  #   # Required to run the correct GBM backend for nvidia GPUs on wayland
  #   GBM_BACKEND = "nvidia-drm";
  #   # Apparently, without this nouveau may attempt to be used instead
  #   # (despite it being blacklisted)
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  # };
}
