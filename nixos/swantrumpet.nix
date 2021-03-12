{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  nix.trustedUsers = [ "root" "o" ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.hostName = "swantrumpet";
  networking.networkmanager.enable = true;
  # networking.useNetworkd = true;

  networking.wg-quick = {
    interfaces.wg0 = {
      address = [ "10.100.0.42/32" ];
      peers = [{
        allowedIPs = [ "10.100.0.1/16" ];
        endpoint = "208.167.253.75:443";
        publicKey = "h9x943YgpQwLIkBPLkdcrpIWoUwlXDUQ7PuaKVK8Cz4=";
        persistentKeepalive = 25;
      }];
      privateKey = "ADRvKNzspjuVrCFGEk2C/P49Nt5U8Sw4he7yQeAjhnM=";
    };
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  i18n = { defaultLocale = "nl_NL.utf8"; };
  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    xfce.xfce4-notifyd
    xfce.xfce4-panel
    xfce.xfce4-battery-plugin
    xfce.xfce4-datetime-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-i3-workspaces-plugin
  ];

  nix.binaryCaches = [ "https://hydra.iohk.io" ];
  nix.binaryCachePublicKeys =
    [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  networking.nameservers = [ "4.4.4.4" "8.8.8.8" ];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.local) return "yes";
    });
  '';

  # utility services
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ gutenprint hplip ];
  services.upower.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  hardware.bluetooth.enable = true;
  services.fwupd.enable = true;
  services.gnome3.gnome-settings-daemon.enable = true;
  hardware.opengl.driSupport32Bit = true;

  virtualisation.docker.enable = true;
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal ];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = { enable = true; };
  programs.dconf.enable = true;
  programs.fish.enable = true;
  services.avahi.enable = true;

  location.latitude = 52.09;
  location.longitude = 5.12;
  hardware.sensor.iio.enable = true;

  # Enable sway wm
  # programs.sway.enable = true;
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput = { enable = true; };
    xkbOptions = "caps:escape";
    windowManager.i3.enable = true;
    desktopManager.xfce = {
      enable = true;
      enableXfwm = false;
      noDesktop = true;
    };
    displayManager.lightdm.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "o";
  };

  systemd.packages = with pkgs.xfce; [ thunar xfce4-notifyd ];

  services.postgresql = {
    enable = true;
    ensureUsers = [{ name = "o"; }];
  };

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.users.o = {
    isNormalUser = true;
    hashedPassword =
      "$6$EEGK4jub86F7Y.xm$sz/KWoMyVfMuBlJQA.aqzBaQ39o1UI1Mj4BUtM9jB6hYbGyLE/Pn5uywM.aK/K6oZY3khDlzcjCInxqNjGc4M1";
    extraGroups = [ "wheel" "docker" "audio" "libvirtd" ];
    shell = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
