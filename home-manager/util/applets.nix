{ config, lib, pkgs, ... }:

{
  services = {
    blueman-applet.enable = true;
    pasystray.enable = true;
    udiskie.enable = true;
  };
}
