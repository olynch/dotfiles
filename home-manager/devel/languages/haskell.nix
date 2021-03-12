{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ stack haskell-language-server ];
}
