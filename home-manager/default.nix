{ config, lib, pkgs, ... }:

{
  imports = [
    ./devel.nix
    ./util.nix
    ./communication.nix
    ./media.nix
    ./base.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "19.09";
}
