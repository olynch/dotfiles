{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      e = "emacsclient -c";
      ls = "exa";
      cat = "bat";
      ps = "procs";
      du = "dust";
      top = "ytop";
    };
  };
}
