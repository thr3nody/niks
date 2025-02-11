{ pkgs, ... }:

{
  services.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
