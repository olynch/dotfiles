{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    inkscape
    rx
    krita
    mpv
    ffmpeg
    spotify
    transmission-gtk
    zathura
    xournalpp
    feh
    torbrowser
    lilypond
    google-chrome
    libreoffice
    zotero
    cozy

    multimc
    crawl

    # Fonts
    nerdfonts
    fira
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };

  home.sessionVariables = { MOZ_USE_XINPUT2 = 1; };

  nixpkgs.config.pulseaudio = true;

  fonts.fontconfig.enable = true;
}
