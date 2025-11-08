{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    prog.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables OBS.";
    };
  };

  config = lib.mkIf config.prog.obs.enable {
    programs.obs-studio = {
      enable = true;

      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };

    boot = {
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      kernelModules = ["v4l2loopback"];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=2 card_label="OBS Cam" exclusive_caps=1
      '';
    };
  };
}
