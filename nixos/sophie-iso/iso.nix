{ config, pkgs, ... }:

# let
#   latest_kernel = pkgs.callPackage ./mainline_kernel.nix {
#     kernelPatches = [
#       pkgs.kernelPatches.bridge_stp_helper
#       pkgs.kernelPatches.request_key_helper
#     ];
#   };
# in
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  # boot.kernelPackages = pkgs.linuxPackagesFor latest_kernel;
  # boot.kernelModules = [ "ath11k" ];
  # boot.kernelParams = [ "memmap=12M\\\\\\\$20M" ];
  # networking.wireless.enable = false;
  # networking.networkmanager.enable = true;
}
