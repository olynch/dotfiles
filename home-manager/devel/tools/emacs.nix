{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://api.github.com/repos/nix-community/emacs-overlay/tarball/facff646180d867f232c39324308376d5187c348;
    }))
  ];

  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacs;
  programs.emacs.extraPackages = epkgs: [ epkgs.vterm epkgs.zmq ];
  services.emacs.enable = true;

  home.packages = with pkgs; [
    ## Module dependencies
    # :checkers spell
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    # :checkers grammar
    languagetool
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :tools lookup & :lang org +roam
    gcc
    gnumake
    sqlite
    autoconf
    automake
    m4
    pkgconfig
    libtool
    libevent
    perl
    # :lang cc
    ccls
    # :lang rust
    rustfmt
    rls
    # nov.el
    unzip
  ];

  home.sessionVariables.DOOMDIR = "~/g/dotfiles/doom";
  home.sessionVariables.EDITOR = "emacsclient -c";
  systemd.user.services.emacs.Service.Environment = "DOOMDIR=~/g/dotfiles/doom";
}
