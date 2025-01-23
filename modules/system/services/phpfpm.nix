{
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
}
