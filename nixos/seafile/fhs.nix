{ pkgs ? import <nixpkgs> {}, ... }:

let seafile-src = pkgs.callPackage ./source.nix {  };
in
pkgs.buildFHSUserEnv {
  name = "seafile-fhs";

  targetPkgs = pkgs: with pkgs; [
    seafile-src
    (python27.withPackages (pypk: with pypk; [
      setuptools ldap urllib3 requests sqlite
    ]))
    sqlite
    ffmpeg
  ];
}
