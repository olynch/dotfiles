{ config, lib, pkgs, ... }:

{
  services = {
    blueman-applet.enable = true;
    pasystray.enable = true;
    udiskie.enable = true;
    dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "600x5-30+50";
          padding = 20;
          horizontal_padding = 20;
        };
        urgency_low = {
          frame_color = "#00ff00";
          background = "#21242B";
          foreground = "#ABB2BF";
        };
        urgency_normal = {
          frame_color = "#ffff00";
          background = "#21242B";
          foreground = "#ABB2BF";
        };
        urgency_critical = {
          frame_color = "#ff0000";
          background = "#21242B";
          foreground = "#ABB2BF";
        };
      };
    };
  };
}
