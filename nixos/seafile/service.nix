{ config, lib, pkgs, ... }:

{
  docker-containers = {
    memcached = {
      image = "memcached:1.5.6";
      extraDockerOptions = [ "--network=seafile-net" ];
    };
    db = {
      image = "mariadb:10.1";
      environment = {
        MYSQL_ROOT_PASSWORD="db_dev";
        MYSQL_LOG_CONSOLE="true";
      };
      volumes = [
        "/home/o/scratch/seafile/data/mysql:/var/lib/mysql"
      ];
      extraDockerOptions = [ "--network=seafile-net" ];
    };
    seafile = {
      dependsOn = ["memcached" "db"];
      image = "seafileltd/seafile-mc:latest";
      ports = [
        "8000:80"
      ];
      volumes = [
        "/home/o/scratch/seafile/data/seafile:/shared"
      ];
      extraDockerOptions = [ "--network=seafile-net" ];
      environment = {
        DB_HOST="db";
        DB_ROOT_PASSWD="db_dev";  # Requested, the value shuold be root's password of MySQL service.
        TIME_ZONE="Etc/UTC";  # Optional, default is UTC. Should be uncomment and set to your local time zone.
        SEAFILE_ADMIN_EMAIL="root@owenlynch.org"; # Specifies Seafile admin user, default is 'me@example.com'.
        SEAFILE_ADMIN_PASSWORD="asecret";     # Specifies Seafile admin password, default is 'asecret'.
        SEAFILE_SERVER_LETSENCRYPT="false";   # Whether to use https or not.
        SEAFILE_SERVER_HOSTNAME="files.owenlynch.org"; # Specifies your host name if https is enabled.
      };
    };
  };
}
