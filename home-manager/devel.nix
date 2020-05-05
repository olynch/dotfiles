{ config, lib, pkgs, ... }:

{
  imports = [
    ./devel/languages/haskell.nix
    ./devel/languages/latex.nix
    ./devel/languages/ocaml.nix
    ./devel/tools/alacritty.nix
    ./devel/tools/fish.nix
    ./devel/tools/emacs.nix
    ./devel/tools/git.nix
    ./devel/fhs/scientific.nix
  ];

  home.packages = with pkgs; [
    graphviz
    ipe
    texmacs
    nodejs
    (callPackage ./devel/languages/python.nix {})
    (callPackage ./devel/languages/R.nix {})
  ];
}
