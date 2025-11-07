{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    netSetup.warp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables cloudflare warp.";
    };
  };

  config = lib.mkIf config.netSetup.warp.enable {
    environment.systemPackages = with pkgs; [
      cloudflare-warp
    ];

    # Autostart warp-svc on startup.
    systemd.packages = [pkgs.cloudflare-warp];
    systemd.targets.multi-user.wants = ["warp-svc.service"];
  };
}
