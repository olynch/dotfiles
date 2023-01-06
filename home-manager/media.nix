{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cozy
    feh
    ffmpeg
    gimp
    google-chrome
    inkscape
    krita
    libreoffice
    lilypond
    mpv
    rx
    spotify
    torbrowser
    transmission-gtk
    vlc
    xournalpp
    zathura
    zotero

    multimc
    crawl
    dwarf-fortress-packages.dwarf-fortress-full

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
