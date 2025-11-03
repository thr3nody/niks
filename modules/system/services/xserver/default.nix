{
  lib,
  config,
  ...
}: {
  options = {
    svcs.xserver.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables xserver.";
    };
  };

  config = lib.mkIf config.svcs.asusd.enable {
    services = {
      xserver = {
        enable = true;
      };

      xserver.xkb = {
        layout = "us";
        variant = "";
      };
      printing.enable = true;
    };
  };
}
