{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Owen Lynch";
    userEmail = "root@owenlynch.org";
  };

  home.packages = with pkgs; [
    gitAndTools.gitAnnex
    gitAndTools.hub
  ];
}
