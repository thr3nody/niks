{
  services.asusd = {
    enable = true;
    enableUserService = true;
    asusdConfig.text = ''
      bat-charge-limit = 80;
    '';
  };
}
