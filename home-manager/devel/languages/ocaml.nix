{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; with ocamlPackages; [
    (lowPrio ocaml)
    reason
    bs-platform
  ];
}
