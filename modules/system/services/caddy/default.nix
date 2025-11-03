{
  lib,
  config,
  ...
}: {
  options = {
    svcs.caddy.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables caddy.";
    };
  };

  config = lib.mkIf config.svcs.caddy.enable {
    services.caddy = {
      enable = true;
    };
  };
}
