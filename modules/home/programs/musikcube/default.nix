{pkgs, ...}: {
  home.packages = [
    pkgs.musikcube # TUI Clipboard Manager
  ];

  xdg.configFile = {
    "musikcube/hotkeys.json" = {
      source = ./hotkeys.json;
      force = true;
    };
    "musikcube/settings.json" = {
      source = ./settings.json;
      force = true;
    };
  };
}
