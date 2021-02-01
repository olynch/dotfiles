{ config, lib, pkgs, ... }:

# let
#   all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
# in
{
  home.packages = with pkgs; [
    # (all-hies.selection { selector = p: { inherit (p) ghc865; };})
    (haskellPackages.ghcWithHoogle (hpk: with hpk; [
      diagrams
      diagrams-cairo
      HaTeX
      sampling
      mwc-random
      rio
      cabal-install
      project-template
      scalpel
      turtle
    ]))
    cabal2nix
    niv
  ];
}
