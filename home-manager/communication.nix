{ config, lib, pkgs, ... }:

{
  imports = [
    ./accounts/owenlynchorg.nix
    ./accounts/oclynch888.nix
    ./accounts/brown.nix
    ./accounts/proqquladmin.nix
    ./accounts/uu.nix
  ];

  home.packages = with pkgs; [
    zoom-us
    obs-studio
    obs-wlrobs
    teams
    skype
    ytalk
  ];

  programs.msmtp.enable = true;
  programs.mbsync.enable = true;
  programs.notmuch.enable = true;
  programs.notmuch.hooks.postNew = let
    addresses = {
      brown = "owen_lynch1@alumni.brown.edu"; 
      gmail = "oclynch888@gmail.com"; 
      root = "root@owenlynch.org"; 
      proqqul = "admin@proqqul.net"; 
      uu = "o.c.lynch@students.uu.nl";
    };
    ignorelist = [
      "nytimes@e.newyorktimes.com"
      "ebay@reply.ebay.com"
      "grads@mssm.edu"
      "discover@airbnb.com"
      "Lenovo@ecomms.lenovo.com"
      "GuildhallAdmissions@SMUGuildhall.org"
    ];
    newslist = [
      "handshake@g.joinhandshake.com"
      "info@email.actionnetwork.org"
      "taibbi@substack.com"
      "simple@simpleapp.hu"
      "simple@simple.hu"
      "shauna.hamilton@voterchoice2020.org"
      "info@cloverfoodlab.com"
      "NfB@brown.edu"
      "info@endcoronavirus.org"
    ];
    financiallist = [
      "estatements@ricreditunion.org"
      "capitalone@notification.capitalone.com"
      "capitalone@message.capitalone.com"
    ];
    custom = {
      shakti = { q = "to:shaktidb@googlegroups.com"; inbox = false; };
      ccv = { q = "to:CCV@LISTSERV.BROWN.EDU"; inbox = false; };
      wyzant = { q = "from:no-reply@wyzant.com"; inbox = false; };
      uu = { q = "from:*@uu.nl"; inbox = true; };
      gh = { q = "from:notifications@github.com"; inbox = false; };
    };
    nmtag = newtags: removetags: query:
      "notmuch tag ${lib.concatMapStringsSep " " (t: "+${t}") newtags} ${lib.concatMapStringsSep " " (t: "-${t}") removetags} \"(${query})\" ";
    tagTo = tag: to: nmtag [tag] [] "to:${to}";
    tagAny = newtags: removetags: queries: nmtag newtags removetags (lib.concatStringsSep " or " queries);
    tagAnyFrom = newtags: removetags: addresses: tagAny newtags removetags (map (a: "from:${a}") addresses);
    tc = tag: q: inbox: nmtag [tag] (["unread"] ++ (if inbox then [] else ["inbox"])) q;
  in ''
    ${lib.concatStringsSep "\n" (builtins.attrValues (lib.mapAttrs tagTo addresses))}

    notmuch tag +list ${lib.concatStringsSep " and " (builtins.attrValues (lib.mapAttrs (tag: a: "tag:${tag}") addresses)) }
    notmuch tag -unread tag:list

    ${tagAnyFrom [] ["inbox" "unread"] ignorelist}
    ${tagAnyFrom ["news"] ["inbox" "unread"] newslist}
    ${tagAnyFrom ["financial"] ["inbox" "unread"] financiallist}

    ${tc "shakti" "to:shaktidb@googlegroups.com" false}
    ${tc "ccv" "to:CCV@LISTSERV.BROWN.EDU" false}
    ${tc "wyzant" "from:/.*@wyzant.com/" false}
    ${tc "uu" "from:/.*@uu.nl/" true}
    ${tc "gh" "from:notifications@github.com" false}
  '';
  programs.astroid.enable = true;
  programs.astroid.externalEditor = "emacsclient -q -c %1";
  programs.astroid.pollScript = ''
    mbsync -a
    env NOTMUCH_CONFIG=$HOME/.config/notmuch/notmuchrc notmuch new
  '';
  # services.imapnotify.enable = true;
}
