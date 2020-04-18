{ config, lib, pkgs, ... }:

{
  programs.emacs.enable = true;
  services.emacs.enable = true;

  home.sessionVariables.DOOMDIR = "~/git/dotfiles/doom";
  systemd.user.services.emacs.Service.Environment = "DOOMDIR=~/git/dotfiles/doom";
}
