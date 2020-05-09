{ config, lib, pkgs, ... }:

let
  myjulia = pkgs.stdenv.mkDerivation {
    name = "julia";
    src = pkgs.fetchurl {
      url = "https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz";
      sha256 = "02k1a17lw7jdzc1ngbr6z6lqs3ivg8h95yxf7i61fy6nmsnqqvgx";
    };
    installPhase = ''
              mkdir $out
              cp -R * $out/
            '';
    dontStrip = true;
  };
  mygr = pkgs.stdenv.mkDerivation {
    name = "gr";
    src = pkgs.fetchurl {
      url = "https://github.com/sciapp/gr/releases/download/v0.48.0/gr-0.48.0-Linux-x86_64.tar.gz";
      sha256 = "1a75kky2prwx1bhjpjikpvxvniz85k5i1xszpvdbnwyhgcq8nn57";
    };
    installPhase = ''
              mkdir $out
              cp -R * $out/
            '';
    dontStrip = true;
  };

  myM2 = pkgs.stdenv.mkDerivation {
    name = "M2";
    src = pkgs.fetchurl {
      url = "http://www2.macaulay2.com/Macaulay2/Downloads/GNU-Linux/Debian/Macaulay2-1.15-amd64-Linux-Debian-10.deb";
      sha256 = "17q3lz33qyb3m32y65r6p3cbivbqp05vdy557k8idmlwgzxj0xxf";
    };
    buildInputs = [ pkgs.dpkg ];
    builder = pkgs.writeScript "builder.sh" ''
      #!{pkgs.bash}/bin/bash
      source $stdenv/setup

      mkdir $out
      mkdir unpacked
      dpkg -x $src unpacked
      mv unpacked/usr/* $out
    '';
  };

  myM2common = pkgs.stdenv.mkDerivation {
    name = "M2common";
    src = pkgs.fetchurl {
      url = "http://www2.macaulay2.com/Macaulay2/Downloads/Common/Macaulay2-1.15-common.deb";
      sha256 = "09sdgmllkbqyzfppj2180ssyzxdhi3mrgh0lgk3fhg8jcnv8c8x3";
    };
    buildInputs = [ pkgs.dpkg ];
    builder = pkgs.writeScript "builder.sh" ''
      #!{pkgs.bash}/bin/bash
      source $stdenv/setup

      mkdir $out
      mkdir unpacked
      dpkg -x $src unpacked
      mv unpacked/usr/* $out
    '';
  };

in
{
  home.packages = [
    (pkgs.buildFHSUserEnv {
      name = "scientific-fhs";

      targetPkgs = pkgs: with pkgs; [
        git
        gitRepo
        gnupg
        autoconf
        curl
        procps
        gnumake
        utillinux
        m4
        gperf
        unzip
        freeglut
        clang
        binutils
        which
        gmp
        libxml2
        cmake

        udev
        coreutils
        alsaLib
        dpkg
        zlib
        freetype
        glib
        zlib
        fontconfig
        openssl
        which
        ncurses
        jdk
        pam
        dbus_glib
        dbus
        pango
        gtk2-x11
        atk
        gdk_pixbuf
        cairo
        xorg.libX11
        xorg.xorgproto
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXext
        xorg.libSM
        xorg.libICE
        xorg.libX11
        xorg.libXrandr
        xorg.libXdamage
        xorg.libXrender
        xorg.libXfixes
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libxcb
        xorg.libXi
        xorg.libXScrnSaver
        xorg.libXtst
        xorg.libXt
        xorg.libXxf86vm
        xorg.libXinerama
        nspr
        cups
        chromium
        nodejs
        pdf2svg

        myjulia
        mygr

        (pkgs.callPackage ../languages/R.nix {})
        (pkgs.callPackage ../languages/python.nix {})

        atom

        myM2
        myM2common
        (gfortran8.cc.override {
          enableShared = true;
        })
        gdbm
        readline70
        (liblapack.override {shared = true;})
        boehmgc
        libxml2

        # Arpack.jl
        arpack
        (pkgs.runCommand "openblas64_" {} ''
          mkdir -p "$out"/lib/
          ln -s ${openblasCompat}/lib/libopenblas.so "$out"/lib/libopenblas64_.so.0
        '')

        # IJulia.jl
        mbedtls
        zeromq3
        # ImageMagick.jl
        imagemagickBig
        # HDF5.jl
        hdf5
        # Cairo.jl
        cairo
        gettext
        pango.out
        glib.out
        # Gtk.jl
        gtk3
        gtk2
        fontconfig
        gdk_pixbuf
        # GZip.jl # Required by DataFrames.jl
        gzip
        zlib
        # GR.jl # Runs even without Xrender and Xext, but cannot save files, so those are required
        qt4
        glfw
        freetype

        #misc
        xorg.libXxf86vm
        xorg.libSM
        xorg.libXtst
        libpng
        expat
        gnome2.GConf
        nss
      ];
      multiPkgs = pkgs: with pkgs; [ zlib ];
      runScript = "bash";
      extraOutputsToInstall = [ "man" "dev" ];
      profile = ''
        export EXTRA_CCFLAGS="-I/usr/include"
        export MATLAB_JAVA="/usr/lib/openjdk/jre"
        export JULIA_CC="clang"
        export GRDIR="${mygr}"
      '';
    })
  ];
}
