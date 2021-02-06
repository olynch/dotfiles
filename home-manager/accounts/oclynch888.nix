{ config, lib, pkgs, ... }:

{
   accounts.email.accounts.oclynch888 = {
    address = "oclynch888@gmail.com";
    userName = "oclynch888@gmail.com";
    realName = "Owen Lynch";
    flavor = "gmail.com";
    astroid.enable = true;
    astroid.sendMailCommand = "msmtp --read-envelope-from --read-recipients";
    folders = {
      drafts = "drafts";
      sent = "sent";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    mbsync.enable = true;
    mbsync.create = "both";
    passwordCommand = "cat .mail-passwords/oclynch888@gmail.com";
    imapnotify = {
        enable = true;
        onNotify = "${pkgs.isync}/bin/mbsync owenlynchorg";
        onNotifyPost = "${pkgs.notmuch}/bin/notmuch new && ${pkgs.libnotify}/bin/notify-send 'oclynch888 mail'";
    };
  }; 
}
