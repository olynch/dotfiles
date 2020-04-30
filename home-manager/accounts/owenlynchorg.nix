{ config, lib, pkgs, ... }:

{
  accounts.email.accounts.owenlynchorg = {
    address = "root@owenlynch.org";
    aliases = [ "postmaster@owenlynch.org" "owen@owenlynch.org" "the_man@owenlynch.org" "the_man_himself@owenlynch.org" ];
    userName = "root@owenlynch.org";
    realName = "Owen Lynch";
    passwordCommand = "cat ~/.mail-passwords/root@owenlynch.org";
    smtp.host = "mx.owenlynch.org";
    smtp.port = 587;
    smtp.tls.useStartTls = true;
    imap.host = "mx.owenlynch.org";
    astroid.enable = true;
    astroid.sendMailCommand = "msmtp --account=owenlynchorg --read-envelope-from --read-recipients";
    folders = {
      drafts = "drafts";
      sent = "sent";
    };
    msmtp.enable = true;
    notmuch.enable = true;
    mbsync.enable = true;
    primary = true;
  };
}
