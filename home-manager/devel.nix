{ config, lib, pkgs, ... }:

{
  imports = [
    ./devel/languages/R.nix
    ./devel/languages/haskell.nix
    ./devel/languages/latex.nix
    ./devel/tools/alacritty.nix
    ./devel/tools/fish.nix
    ./devel/tools/emacs.nix
    ./devel/tools/git.nix
  ];

  home.packages = with pkgs; [
    ripgrep
  ];
}
