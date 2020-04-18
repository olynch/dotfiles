{ config, lib, pkgs, ... }:

{
  imports = [
    ./util/X.nix
  ];

  programs.gpg.enable = true;
  programs.home-manager.enable = true;
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/o/annex/Secrets/pass";
      PASSWORD_STORE_KEY = "5F22F5706D010E72";
    };
  };

  services.gpg-agent.enable = true;

  home.packages = [ (pkgs.callPackage ./util/scripts {}) ];
}
