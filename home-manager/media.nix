{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
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
