{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    dvipng
  ];

  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-medium; };
  };
}
