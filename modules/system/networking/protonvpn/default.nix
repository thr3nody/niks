{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    netSetup.protonvpn.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables protonvpn.";
    };
  };

  config = lib.mkIf config.netSetup.protonvpn.enable {
    networking.firewall.checkReversePath = false;
    environment.systemPackages = with pkgs; [wireguard-tools protonvpn-gui];
  };
}
