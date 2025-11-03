{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    svcs.nextdns.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables nextdns.";
    };
  };

  config = lib.mkIf config.svcs.nextdns.enable {
    environment.systemPackages = [pkgs.nextdns];
    services.nextdns = {
      enable = true;
      arguments = ["-config" "10.0.3.0/24=abcdef" "-cache-size" "10MB"];
    };
  };
}
