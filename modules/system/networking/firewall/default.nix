{
  lib,
  config,
  ...
}: {
  options = {
    netSetup.firewall.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables firewall.";
    };
  };

  config = lib.mkIf config.netSetup.firewall.enable {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };
  };
}
