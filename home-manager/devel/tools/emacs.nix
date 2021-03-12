{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    }))
  ];
  programs.emacs.enable = true;
  # programs.emacs.package = pkgs.emacsGit;
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
    # :lang nix
    nixfmt
    # :lang org +roam
    graphviz
  ];

  home.sessionVariables.DOOMDIR = "~/g/dotfiles/doom";
  home.sessionVariables.EDITOR = "emacsclient -c";
  systemd.user.services.emacs.Service.Environment = "DOOMDIR=~/g/dotfiles/doom";
}
