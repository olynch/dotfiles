{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
    discord
    zoom-us
  ];
}
