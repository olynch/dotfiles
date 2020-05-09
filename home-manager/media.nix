{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    # inkscape
    krita
    mpv
    ffmpeg
    okular
    spotify
    steam
    transmission-gtk
    zathura
    feh
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2=1;
  };
}
