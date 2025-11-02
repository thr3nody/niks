{
  lib,
  config,
  ...
}: {
  options = {
    networks.firewall.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables firewall.";
    };
  };

  config = lib.mkIf config.networks.firewall.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };
  };
}
