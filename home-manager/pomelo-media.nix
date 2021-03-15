{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    krita
    mpv
    ffmpeg
    spotify
    zathura
    xournalpp
    feh
    zotero

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
