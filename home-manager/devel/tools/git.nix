{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = false;
    userName = "Owen Lynch";
    userEmail = "root@owenlynch.org";
    extraConfig = {
      init.defaultBranch = "main";
      github.user = "olynch";
      pull.rebase = "true";
    };
  };

  home.packages = with pkgs; [
    git
    gitAndTools.gitAnnex
    gitAndTools.hub
    git-lfs
  ];
}
