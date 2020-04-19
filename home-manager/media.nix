{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    evince
    gimp
    inkscape
    krita
    mpv
    transmission-gtk
    zathura
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };
}
