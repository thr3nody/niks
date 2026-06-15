{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    graphics = {
      opengl.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables opengl.";
      };

      cpu = lib.mkOption {
        type = lib.types.enum ["intel" "amd-with-amdvlk" "none" "amd"];
        default = "none";
        description = "CPU vendor for iGPU driver.";
      };

      nvidia.vaapiEnable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Install vaapi driver for Nvidia.";
      };

      extraPackages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
        description = "More extra packages to add.";
      };
    };
  };

  config = lib.mkIf config.graphics.opengl.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; (
        lib.optionals
        (config.graphics.cpu == "intel")
        [
          intel-media-driver
          vpl-gpu-rt
          intel-vaapi-driver
          intel-compute-runtime
          libvdpau-va-gl
        ]
        ++ lib.optionals
        (config.graphics.cpu == "amd-with-amdvlk")
        [
          amdvlk
        ]
        ++ lib.optionals
        config.graphics.nvidia.vaapiEnable
        [
          nvidia-vaapi-driver
        ]
        ++ config.graphics.extraPackages
      );
    };
  };
}
