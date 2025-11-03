{
  lib,
  config,
  ...
}: {
  options = {
    svcs.asusd.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enables asusd.";
    };
  };

  config = lib.mkIf config.svcs.asusd.enable {
    services.asusd = {
      enable = true;
      enableUserService = true;
    };
  };
}
