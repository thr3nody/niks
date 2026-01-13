{
  lib,
  config,
  ...
}: {
  options = {
    svcs.actual.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables actual financing app.";
    };
  };

  config = lib.mkIf config.svcs.actual.enable {
    services.actual = {
      enable = true;
      settings.port = 3030;
    };
  };
}
