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
  programs.direnv.enableNixDirenvIntegration = true;

  programs.mcfly.enable = true;

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

  # services.redshift = {
  #   enable = true;
  #   package = pkgs.gammastep;
  #   latitude = "52.09";
  #   longitude = "5.10";
  # };

  home.packages = with pkgs; [
    gammastep
    (pkgs.callPackage ./util/scripts {})
    coreutils
    htop
    pavucontrol
    gcolor2
    # appimage-run
    seafile-client
    dtrx
    scrot
    tree
    imagemagick
    binutils
    inetutils
    vagrant
    netcat
    magic-wormhole
    rubber
    dmenu
    pinentry
    anki
    croc
    docker-compose
    yarn
    pandoc

    # Rust replacements
    ripgrep
    fd
    sd
    ruplacer
    bat
    exa
    procs
    du-dust
    tokei
    tealdeer
    bandwhich
    
  ];
}
