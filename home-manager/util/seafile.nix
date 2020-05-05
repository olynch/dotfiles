{ config, lib, pkgs, ... }:

{
  systemd.user.services.seafile = {
    Unit = {
      Description = "Seafile Client";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.seafile-client}/bin/seafile-applet";
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
