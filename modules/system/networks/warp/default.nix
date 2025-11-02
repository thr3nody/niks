{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    networks.warp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables cloudflare warp.";
    };
  };

  config = lib.mkIf config.networks.warp.enable {
    environment.systemPackages = with pkgs; [
      cloudflare-warp
    ];

    # Autostart warp-svc on startup.
    systemd.packages = [pkgs.cloudflare-warp];
    systemd.targets.multi-user.wants = ["warp-svc.service"];
  };
}
