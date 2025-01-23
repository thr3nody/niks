{pkgs, ...}: {
  services.caddy = {
    enable = true;
    # configFile = pkgs.writeText "CaddyFile" ''
    #   seleksi.fiksi.com
    #
    #   root * /var/www/fiksi
    #   php_fastcgi unix//run/php/php-version-fpm.sock
    #   file_server
    # '';
  };
}
