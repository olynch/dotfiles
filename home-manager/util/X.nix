{ config, lib, pkgs, ... }:

{
  xsession.preferStatusNotifierItems = true;

  xdg.configFile."taffybar/taffybar.hs".text = lib.readFile ./taffybar.hs;
  home.file.".xmonad/xmonad.hs".text = lib.readFile ./xmonad.hs;
  home.file.".XCompose".text = lib.readFile ./XCompose;

  services.taffybar.enable = true;

  services.picom.enable = true;
  services.status-notifier-watcher.enable = true;
  services.xembed-sni-proxy.enable = true;
}
