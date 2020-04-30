{ config, lib, pkgs, ... }:

{
  programs.emacs.enable = true;
  programs.emacs.package = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/olynch/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ../../../doom;
    extraPackages = epkgs: [ pkgs.ocamlformat ];
    abortOnNotFound = false;
  };
  services.emacs.enable = true;

  home.sessionVariables.DOOMDIR = "~/git/dotfiles/doom";
  home.sessionVariables.EDITOR = "emacsclient -c";
  systemd.user.services.emacs.Service.Environment = "DOOMDIR=~/git/dotfiles/doom";
}
