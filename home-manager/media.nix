{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    inkscape
    krita
    mpv
    okular
    transmission-gtk
    zathura
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };
}
