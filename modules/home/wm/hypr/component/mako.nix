{ config, ... }:

{
  services.mako = with config.colorScheme.palette; {
    enable = true;
    actions = true;
    backgroundColor = "#${base01}";
    borderColor = "#${base05}";
    borderRadius = 5;
    borderSize = 2;
    padding = "10,20,10,20";
    textColor = "#${base06}";
    layer = "overlay";
    defaultTimeout = 5000;
  };
}
