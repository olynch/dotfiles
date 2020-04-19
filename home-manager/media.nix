{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    inkscape
    gimp
    mpv
    transmission-gtk
    zathura
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };
}
