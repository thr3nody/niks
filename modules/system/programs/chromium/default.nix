{
  lib,
  config,
  ...
}: {
  options = {
    progs.qrom.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables Chromium.";
    };
  };

  config = lib.mkIf config.progs.qrom.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      ];
    };
  };
}
