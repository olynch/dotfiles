{ config, lib, pkgs, ... }:

{
  accounts.email.accounts.proqquladmin = {
    address = "admin@proqqul.net";
    aliases = [ "postmaster@proqqul.net" "webadmin@proqqul.net" "sysadmin@proqqul.net" ];
    userName = "admin@proqqul.net";
    realName = "Proqqul Admin";
    passwordCommand = "cat ~/.mail-passwords/admin@proqqul.net";
    smtp.host = "mx.proqqul.net";
    smtp.port = 587;
    smtp.tls.useStartTls = true;
    imap.host = "mx.proqqul.net";
    astroid.enable = true;
    astroid.sendMailCommand = "msmtp --account=proqquladmin --read-envelope-from --read-recipients";
    folders = {
      drafts = "drafts";
      sent = "sent";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    mbsync.enable = true;
    mbsync.create = "both";
    primary = false;
  };
}
