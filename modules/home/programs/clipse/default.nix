{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.clipse # TUI Clipboard Manager
  ];

  xdg.configFile."clipse/config.json" = {
    source = ./config.json;
    force = true;
  };
}
