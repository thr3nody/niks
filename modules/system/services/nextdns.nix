{pkgs, ...}: {
  environment.systemPackages = [ pkgs.nextdns ];
  services.nextdns.enable = true;
}
