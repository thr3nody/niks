{
  lib,
  config,
  ...
}: {
  options = {
    svcs.tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables tailscale.";
    };
  };

  config = lib.mkIf config.svcs.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };
}
