{ config, lib, pkgs, ... }:

{
  accounts.email.accounts.uu = {
    address = "o.c.lynch@students.uu.nl";
    userName = "o.c.lynch@students.uu.nl";
    realName = "Owen Lynch";
    astroid.enable = true;
    astroid.sendMailCommand = "msmtp --read-envelope-from --read-recipients";
    folders = {
      drafts = "drafts";
      sent = "sent";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    mbsync = {
        enable = true;
        create = "both";
    };
    imapnotify = {
        enable = true;
        onNotify = "${pkgs.isync}/bin/mbsync uu";
        onNotifyPost = "${pkgs.notmuch}/bin/notmuch new && ${pkgs.libnotify}/bin/notify-send 'uu mail'";
    };
    passwordCommand = "cat .mail-passwords/o.c.lynch@students.uu.nl";
    smtp.host = "smtp.office365.com";
    smtp.port = 587;
    smtp.tls.useStartTls = true;
    imap.host = "outlook.office365.com";
  }; 
}
