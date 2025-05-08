{config, ...}: {
  services.mako = with config.colorScheme.palette; {
    enable = true;
    settings = {
      actions = true;
      background-color = "#${base01}";
      border-color = "#${base05}";
      border-radius = 5;
      border-size = 2;
      padding = "10,20,10,20";
      text-color = "#${base06}";
      layer = "overlay";
      default-timeout = 5000;
    };
  };
}
