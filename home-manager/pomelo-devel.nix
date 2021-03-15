{ config, lib, pkgs, ... }:

{
  imports = [
    ./devel/languages/latex.nix
    ./devel/languages/julia.nix
    ./devel/tools/alacritty.nix
    ./devel/tools/fish.nix
    ./devel/tools/emacs.nix
    ./devel/tools/git.nix
  ];

  programs.scientific-fhs = {
    enable = true;
    juliaVersions = [
      {
        version = "julia_16";
        default = true;
      }
      { version = "julia_15"; }
      { version = "julia_10"; }
    ];
    enableNVIDIA = true;
  };

  home.packages = with pkgs; [ ipe texmacs cachix racket ];

  home.sessionVariables = {
    TEXMACS_PATH = "${pkgs.texmacs}/share/TeXmacs";
    TEXMACS_HOME_PATH = "$HOME/.TeXmacs";
  };
}
