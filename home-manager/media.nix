{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    # (callPackage ./pkgs/inkscape.nix {
    #   extraPythonPackages = (ps: with ps; [ pygobject3 ]);
    # })
    inkscape
    krita
    mpv
    ffmpeg
    okular
    spotify
    steam
    transmission-gtk
    zathura
    xournalpp
    feh
    torbrowser
    ardour
    # openshot-qt
    zynaddsubfx
    helm
    drumkv1
    ipe
    lilypond
    google-chrome
    nyxt
    libreoffice

    multimc
    crawl

    # Fonts
    nerdfonts
  ];

  programs = {
    chromium.enable = true;
    firefox.enable = true;
  };

  home.sessionVariables = {
    MOZ_USE_XINPUT2=1;
  };

  nixpkgs.config.pulseaudio = true;

  fonts.fontconfig.enable = true;
}
