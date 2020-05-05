{ config, lib, pkgs, ... }:

{
  imports = [
    ./accounts/owenlynchorg.nix
    ./accounts/oclynch888.nix
    ./accounts/brown.nix
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
  programs.astroid.externalEditor = "emacsclient -q -c %1";
  programs.astroid.pollScript = ''
    mbsync -a
    notmuch new
  '';
  # services.imapnotify.enable = true;
}
