{ config, lib, pkgs, ... }:

{
  imports = [
    # ./devel/languages/haskell.nix
    ./devel/languages/latex.nix
    # ./devel/languages/ocaml.nix
    ./devel/tools/alacritty.nix
    ./devel/tools/fish.nix
    ./devel/tools/emacs.nix
    ./devel/tools/git.nix
    # ./devel/fhs/scientific.nix
  ];

  home.packages = with pkgs; [
    graphviz
    ipe
    texmacs
    nodejs
    love_11
    (callPackage ./devel/languages/python.nix {})
    kakoune
    # (callPackage ./devel/languages/R.nix {})
    cargo
    rustc
    vscode
    zotero

    cachix
  ];
}
