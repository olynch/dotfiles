{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "swantrumpet";
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  i18n = {
    defaultLocale = "nl_NL.utf8";
  };
  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [ ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # utility services
  services.printing.enable = true;
  services.upower.enable = true;
  services.blueman.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  hardware.bluetooth.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape";
    libinput.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.users.o = {
    isNormalUser = true;
    hashedPassword = "$6$EEGK4jub86F7Y.xm$sz/KWoMyVfMuBlJQA.aqzBaQ39o1UI1Mj4BUtM9jB6hYbGyLE/Pn5uywM.aK/K6oZY3khDlzcjCInxqNjGc4M1";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = "${pkgs.fish}/bin/fish";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
