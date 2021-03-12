{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ beam.interpreters.elixir nodejs inotify-tools ];
}
