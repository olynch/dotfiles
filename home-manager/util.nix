{ config, lib, pkgs, ... }:

{
  imports = [
    ./util/X.nix
    ./util/applets.nix
  ];

  programs.gpg.enable = true;
  services.gnome-keyring.enable = true;
  programs.home-manager.enable = true;
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/o/annex/Secrets/pass";
      PASSWORD_STORE_KEY = "5F22F5706D010E72";
    };
  };

  services.gpg-agent.enable = true;

  home.packages = with pkgs; [
    (pkgs.callPackage ./util/scripts {})
    coreutils
    htop
    ripgrep
    tldr
    pavucontrol
    gcolor2
    appimage-run
    seafile-client
    dtrx
    scrot
    tree
  ];
}
