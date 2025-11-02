{
  config,
  lib,
  ...
}: {
  options = {
    graphics.nvidia.stable.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables nvidia stable driver.";
    };
  };

  config = lib.mkIf config.graphics.nvidia.stable.enable {
    services.xserver.videoDrivers = ["modesetting" "nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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

    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
