{ config, lib, pkgs, ... }:

{
  accounts.email.accounts.brown = {
    address = "owen_lynch1@brown.edu";
    userName = "owen_lynch1@brown.edu";
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
    passwordCommand = "cat .mail-passwords/owen_lynch1@brown.edu";
  }; 
}
