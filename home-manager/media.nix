{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    inkscape
    krita
    mpv
    okular
    spotify
    transmission-gtk
    zathura
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2=1;
  };
}
