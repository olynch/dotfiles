{ config, lib, pkgs, ... }:

{
  xdg.configFile."taffybar/taffybar.hs".text = lib.readFile ./taffybar.hs;
  home.file.".xmonad/xmonad.hs".text = lib.readFile ./xmonad.hs;

  services.taffybar.enable = true;

  services.status-notifier-watcher.enable = true;
}
