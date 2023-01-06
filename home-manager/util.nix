{ config, lib, pkgs, ... }:

{
  imports = [
    # ./util/X.nix
    ./util/applets.nix
  ];

  programs.gpg.enable = true;
  # services.gnome-keyring.enable = true;
  programs.home-manager.enable = true;
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/o/annex/Secrets/pass";
      PASSWORD_STORE_KEY = "5F22F5706D010E72";
    };
  };

  services.gpg-agent.enable = true;
  services.gnome-keyring.enable = true;

  programs.direnv.enable = true;
  # programs.direnv.enableNixDirenvIntegration = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  home.packages = with pkgs; [
    gammastep
    (pkgs.callPackage ./util/scripts { })
    coreutils
    htop
    pavucontrol
    gcolor2
    # appimage-run
    seafile-client
    dtrx
    tree
    imagemagick
    binutils
    inetutils
    netcat
    rubber
    dmenu
    pinentry
    anki
    croc
    pandoc
    autorandr
    arandr
    zip

    # Rust replacements
    ripgrep
    fd
    sd
    ruplacer
    bat
    exa
    procs
    du-dust
    tealdeer
    bandwhich
    tokei
  ];
}
