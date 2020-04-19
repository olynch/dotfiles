{ config, lib, pkgs, ... }:

{
  imports = [
    ./accounts/owenlynchorg.nix
    ./accounts/oclynch888.nix
  ];

  home.packages = with pkgs; [
    signal-desktop
    discord
    zoom-us
  ];

  programs.msmtp.enable = true;
  programs.mbsync.enable = true;
  programs.notmuch.enable = true;
  programs.astroid.enable = true;
}
