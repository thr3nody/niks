{
  lib,
  config,
  ...
}: {
  options = {
    audio.pulseaudio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables pulseaudio.";
    };
  };
  config = lib.mkIf config.audio.pulseaudio.enable {
    services.pulseaudio.enable = true;
  };
}
