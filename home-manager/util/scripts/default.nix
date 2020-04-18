{ stdenv }:

stdenv.mkDerivation {
  name = "misc-scripts";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
    chmod +x $out/bin/*
  '';
}
