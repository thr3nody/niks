{ pkgs, ... }:

{
  hardware.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
