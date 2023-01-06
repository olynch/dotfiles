{ config, lib, pkgs, ... }:

{
  imports = [
    ./devel/languages/latex.nix
    ./devel/languages/julia.nix
    # ./devel/languages/python.nix
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
    enableNVIDIA = false;
  };

  home.packages = with pkgs; [ ipe texmacs cachix racket rustup cookiecutter ];

  nixpkgs.config.allowUnsupportedSystem = true;

  home.sessionVariables = { TEXMACS_HOME_PATH = "$HOME/.TeXmacs"; };
}
