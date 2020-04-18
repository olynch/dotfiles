{ config, lib, pkgs, ... }:

{
  programs.git.enable = true;

  home.packages = with pkgs; [
    gitAndTools.gitAnnex
    gitAndTools.hub
  ];
}
