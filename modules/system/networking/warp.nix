{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cloudflare-warp
  ];

  # Autostart warp-svc on startup.
  systemd.packages = [pkgs.cloudflare-warp];
  systemd.targets.multi-user.wants = ["warp-svc.service"];

}
