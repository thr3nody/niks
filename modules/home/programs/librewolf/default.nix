{
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "media.autoplay.blocking_policy" = 2;
    };
    policies = {
      DisableTelemetry = true;
    };
  };
}
