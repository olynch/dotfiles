{ config, lib, pkgs, ... }:

{
  imports = [
    ./devel/languages/elixir.nix
    ./devel/languages/latex.nix
    # ./devel/languages/python.nix
    ./devel/languages/julia.nix
    ./devel/languages/haskell.nix
    ./devel/tools/alacritty.nix
    ./devel/tools/fish.nix
    ./devel/tools/emacs.nix
    ./devel/tools/git.nix
  ];

  home.packages = with pkgs; [ ipe texmacs cachix racket ];

  home.sessionVariables = {
    TEXMACS_PATH = "${pkgs.texmacs}/share/TeXmacs";
    TEXMACS_HOME_PATH = "$HOME/.TeXmacs";
  };
}
