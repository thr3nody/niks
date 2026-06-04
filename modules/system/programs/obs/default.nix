{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    progs.obs = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables OBS.";
      };

      cudaSupport = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable CUDA support for Nvidia cards.";
      };

      extraPlugins = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
        description = "Additional OBS plugins to install.";
      };

      virtualCamera = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable OBS virtual camera.";
      };
    };
  };

  config = lib.mkIf config.progs.obs.enable {
    programs.obs-studio = {
      enable = true;

      package = pkgs.obs-studio.override {
        inherit (config.progs.obs) cudaSupport;
      };

      plugins = with pkgs.obs-studio-plugins;
        [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ]
        ++ config.progs.obs.extraPlugins;
    };

    boot = lib.mkIf config.progs.obs.virtualCamera {
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
