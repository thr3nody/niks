{pkgs, ...}: {
  environment.systemPackages = [pkgs.nextdns];
  services.nextdns = {
    enable = true;
    arguments = ["-config" "10.0.3.0/24=abcdef" "-cache-size" "10MB"];
  };
}
