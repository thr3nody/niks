{
  lib,
  config,
  ...
}: {
  options = {
    prog.qrom.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables Chromium.";
    };
  };

  config = lib.mkIf config.prog.qrom.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
      ];
    };
  };
}
