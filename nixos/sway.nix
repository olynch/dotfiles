{ config, lib, pkgs, ... }:

# let
#   scripts = pkgs.stdenv.mkDerivation {
#         name = "misc-scripts";
#         src = ./bin;
#         installPhase = ''
#           mkdir -p $out/bin
#           cp $src/* $out/bin/
#           chmod +x $out/bin/*
#         '';
#       };
# in

{
  # programs.sway = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     swaylock # lockscreen
  #     swayidle
  #     xwayland # for legacy apps
  #     waybar # status bar
  #     mako # notification daemon
  #     kanshi # autorandr
  #     dmenu
  #     jq
  #     fzf
  #     scripts
  #     brightnessctl
  #     playerctl
  #     rofi
  #   ];
  # };

  # environment = {
  #   etc = {
  #     # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
  #     "sway/config".source = ../sway/config;
  #     # "xdg/waybar/config".source = ../waybar/config;
  #     # "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
  #   };
  # };

  # Here we but a shell script into path, which lets us start sway.service (after importing the environment of the login shell).
  environment.systemPackages = with pkgs; [
    (
      pkgs.writeTextFile {
        name = "startsway";
        destination = "/bin/startsway";
        executable = true;
        text = ''
          #! ${pkgs.bash}/bin/bash

          # first import environment variables from the login manager
          systemctl --user import-environment
          # then start the service
          exec systemctl --user start sway.service
        '';
      }
    )
  ];

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  systemd.user.services.sway = {
    description = "Sway - Wayland window manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    # We explicitly unset PATH here, as we want it to be set by
    # systemctl --user import-environment in startsway
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  programs.waybar.enable = true;
}
