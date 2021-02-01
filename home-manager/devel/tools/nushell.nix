{ config, lib, pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    settings = {
      edit_mode = "vi";
      startup = [ "alias e [] { emacsclient -c }" ];
    };
  };
}
