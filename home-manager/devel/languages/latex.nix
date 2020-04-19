{ config, lib, pkgs, ... }:

{
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) collection-basic; };
  };
}
