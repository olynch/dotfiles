{ lib, buildPackages, fetchurl, perl, buildLinux, modDirVersionArg ? null, ...
}@args:

with lib;

buildLinux (args // rec {
  version = "5.10.1";

  # modDirVersion needs to be x.y.z, will automatically add .0 if needed
  modDirVersion = if (modDirVersionArg == null) then
    concatStringsSep "." (take 3 (splitVersion "${version}.0"))
  else
    modDirVersionArg;

  # branchVersion needs to be x.y
  extraMeta.branch = versions.majorMinor version;

  src = fetchurl {
    url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
    sha256 = "0p2fl7kl4ckphq17xir7n7vgrzlhbdqmyd2yyp4yilwvih9625pd";
  };

  extraConfig = ''
    CFG80211 m
    MAC80211 m
    CRYPTO_MICHAEL_MIC m
    ATH11K m
  '';
} // (args.argsOverride or { }))
