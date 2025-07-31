{pkgs, ...}: {
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
}
