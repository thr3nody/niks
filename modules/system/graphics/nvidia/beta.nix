{
  config,
  lib,
  ...
}: {
  options = {
    graphics.nvidia.beta.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables nvidia beta driver.";
    };
  };

  config = lib.mkIf config.graphics.nvidia.beta.enable {
    services.xserver.videoDrivers = ["modesetting" "nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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
  };
}
