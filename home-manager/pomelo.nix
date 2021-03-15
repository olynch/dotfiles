{ config, lib, pkgs, ... }:

{
  imports =
    [ ./pomelo-devel.nix ./util.nix ./pomelo-media.nix ./base.nix ./wm.nix ];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "19.09";
}
