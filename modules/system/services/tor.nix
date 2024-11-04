{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.tor-browser
  ];

  services.tor = {
    enable = true; 

    enableGeoIP = false;

    torsocks.enable = true;

    client = {
      enable = true;
    };

    settings = {

      MaxAdvertisedBandwidth = "100 MB";  
      BandWidthRate = "50 MB";  
      RelayBandwidthRate = "50 MB";  
      RelayBandwidthBurst = "100 MB"; 

      ExitPolicy = ["reject *:*"];  

      CookieAuthentication = true;  
      AvoidDiskWrites = 1; 
      HardwareAccel = 1;  
      SafeLogging = 1; 
      NumCPUs = 3;   

      ORPort = [443];
    };
  };
}
