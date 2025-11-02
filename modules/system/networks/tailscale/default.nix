{
  lib,
  config,
  ...
}: {
  options = {
    networks.tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables tailscale.";
    };
  };

  config = lib.mkIf config.networks.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };
}
