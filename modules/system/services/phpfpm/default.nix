{
  lib,
  config,
  ...
}: {
  options = {
    svcs.phpfpm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables phpfpm.";
    };
  };

  config = lib.mkIf config.svcs.phpfpm.enable {
    services.phpfpm.pools.mypool = {
      user = "nobody";
      settings = {
        "listen" = "/var/run/phpfpm/localhost.sock";
        "pm" = "dynamic";
        "pm.max_children" = 5;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 3;
        "pm.max_requests" = 500;
      };
    };
  };
}
