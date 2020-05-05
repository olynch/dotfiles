{ stdenv, fetchurl, python, sqlite, ffmpeg, libselinux, utillinux, autoPatchelfHook }:

stdenv.mkDerivation {
  name = "seafile";
  src = fetchurl {
    url = "https://s3.eu-central-1.amazonaws.com/download.seadrive.org/seafile-server_7.1.3_x86-64.tar.gz";
    sha256 = "0pz1pid8a18dwq7la0v3g4ny915pp6dj9hmpddp668y9hhlh9qa1";
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    (python.withPackages (pypk: with pypk; [
      setuptools ldap urllib3 requests sqlite
    ]))
    sqlite
    ffmpeg
    libselinux
    utillinux
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp -R * $out/bin
  '';
}
