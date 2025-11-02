{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    graphics.opengl.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables opengl.";
    };
  };

  config = lib.mkIf config.graphics.opengl.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-vaapi-driver
        intel-compute-runtime
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
  };
}
