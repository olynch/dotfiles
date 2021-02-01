{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Owen Lynch";
    userEmail = "root@owenlynch.org";
    extraConfig = {
      github.user = "olynch";
      pull.rebase = "true";
    };
  };

  home.packages = with pkgs; [
    gitAndTools.gitAnnex
    gitAndTools.hub
  ];
}
