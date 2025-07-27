{
  pkgs,
  config,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    # enableVirtualCamera = true;

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
    extraModulePackages = [
      # TODO: After flake update, just use the regular v4l2loopback package, refer to https://discourse.nixos.org/t/obs-virtual-camera-broken-in-recent-unstable/65450
      (pkgs.linuxPackages.v4l2loopback.overrideAttrs {
        version = "0.13.2-manual";
        src = pkgs.fetchFromGitHub {
          owner = "umlaeute";
          repo = "v4l2loopback";
          rev = "v0.13.2";
          hash = "sha256-rcwgOXnhRPTmNKUppupfe/2qNUBDUqVb3TeDbrP5pnU=";
        };
      })
    ];
    kernelModules = ["v4l2loopback"];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=2 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
