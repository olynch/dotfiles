{ config, lib, pkgs, ... }:

{
  accounts.email.accounts.brown = {
    address = "owen_lynch1@alumni.brown.edu";
    userName = "owen_lynch1@alumni.brown.edu";
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
    imapnotify = {
        enable = true;
        onNotify = "${pkgs.isync}/bin/mbsync owenlynchorg";
        onNotifyPost = "${pkgs.notmuch}/bin/notmuch new && ${pkgs.libnotify}/bin/notify-send 'brown mail'";
    };
    passwordCommand = "cat .mail-passwords/owen_lynch1@brown.edu";
  }; 
}
