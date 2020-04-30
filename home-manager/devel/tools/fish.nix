{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      e = "emacsclient -c";
    };
  };
}
