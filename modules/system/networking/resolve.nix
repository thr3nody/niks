{
  networking.resolvconf.enable = false;
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    fallbackDns = ["1.1.1.1" "1.0.0.1"];
    extraConfig = ''
      DNS=1.1.1.1 1.0.0.1
      FallbackDNS=2606:4700:4700::1111 2606:4700:4700::1001
      DNSOverTLS=yes
    '';
  };
}
