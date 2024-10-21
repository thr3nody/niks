{ config, ... }:

{
  services.mako = with config.colorScheme.palette; {
    enable = true;
    backgroundColor = "#${base01}";
    borderColor = "#${base06}";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#${base06}";
    layer = "overlay";
  };
}
