{ pkgs ? import <nixpkgs> {  }}:

{
  seafile = pkgs.callPackage ./source.nix {  };
}
