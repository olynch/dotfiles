{ config, lib, pkgs, ... }:

{
  options.home.configDirectory = lib.mkOption {
    type = lib.types.path;
    defaultText = "~/git/dotfiles";
    description = "The path to the config directory";
  };

}
