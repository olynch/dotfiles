{ lib, pkgs, enableJulia ? true, juliaVersion ? "julia_16", enableConda ? true
, condaInstallationPath ? "~/.conda", condaJlEnv ? "conda_jl"
, pythonVersion ? "3.8", enableGraphical ? true, enableNVIDIA ? false, ... }:

with lib;
let
  standardPackages = pkgs:
    with pkgs; [
      autoconf
      binutils
      clang
      cmake
      curl
      expat
      gmp
      gnumake
      gperf
      libxml2
      m4
      nss
      openssl
      stdenv.cc
      unzip
      utillinux
      which
      which
    ];

  customGr = with pkgs; callPackage ./gr.nix { };

  graphicalPackages = pkgs:
    with pkgs; [
      atk
      cairo
      customGr
      fontconfig
      freetype
      gdk_pixbuf
      gettext
      glfw
      glib.out
      gnome2.GConf
      gtk2
      gtk2-x11
      gtk3
      libGL
      libpng
      libselinux
      ncurses
      nspr
      pango.out
      pdf2svg
      qt4
      xorg.libICE
      xorg.libSM
      xorg.libSM
      xorg.libX11
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXinerama
      xorg.libXrandr
      xorg.libXrandr
      xorg.libXrender
      xorg.libXt
      xorg.libXtst
      xorg.libXtst
      xorg.libXxf86vm
      xorg.libXxf86vm
      xorg.libxcb
      xorg.xorgproto
    ];

  nvidiaPackages = pkgs:
    with pkgs; [
      cudatoolkit_11
      cudnn_cudatoolkit_11
      linuxPackages.nvidia_x11
    ];

  juliaPackages = pkgs: version:
    with pkgs;
    let julias = callPackage ./julia.nix { };
    in [ julias."${version}" ];

  condaPackages = pkgs:
    with pkgs;
    [ (callPackage ./conda.nix { installationPath = condaInstallationPath; }) ];

  grPackages = pkgs: with pkgs; [ ];

  targetPkgs = pkgs:
    (standardPackages pkgs)
    ++ optionals enableGraphical (graphicalPackages pkgs)
    ++ optionals enableJulia (juliaPackages pkgs juliaVersion)
    ++ optionals enableConda (condaPackages pkgs)
    ++ optionals enableNVIDIA (nvidiaPackages pkgs);

  std_envvars = ''
    export EXTRA_CCFLAGS="-I/usr/include"
    export FONTCONFIG_FILE=/etc/fonts/fonts.conf
    export LIBARCHIVE=${pkgs.libarchive.lib}/lib/libarchive.so
  '';

  graphical_envvars = ''
    export QTCOMPOSE=${pkgs.xorg.libX11}/share/X11/locale
    export GRDIR=${customGr}
  '';

  conda_envvars = ''
    export NIX_CFLAGS_COMPILE="-I${condaInstallationPath}/include"
    export NIX_CFLAGS_LINK="-L${condaInstallationPath}lib"
    export PATH=${condaInstallationPath}/bin:$PATH
    source ${condaInstallationPath}/etc/profile.d/conda.sh
  '';

  conda_julia_envvars = ''
    export CONDA_JL_HOME=${condaInstallationPath}/envs/${condaJlEnv}
  '';

  nvidia_envvars = ''
    export CUDA_PATH=${pkgs.cudatoolkit_11}
    export LD_LIBRARY_PATH=${pkgs.cudatoolkit_11}/lib:${pkgs.cudnn_cudatoolkit_11}/lib:${pkgs.cudatoolkit_11.lib}/lib:${pkgs.zlib}/lib:$LD_LIBRARY_PATH
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
  '';

  envvars = std_envvars + optionalString enableGraphical graphical_envvars
    + optionalString enableConda conda_envvars
    + optionalString (enableConda && enableJulia) conda_julia_envvars
    + optionalString enableNVIDIA nvidia_envvars;

  extraOutputsToInstall = [ "man" "dev" ];

  multiPkgs = pkgs: with pkgs; [ zlib ];

  condaInitScript = ''
    conda-install
    conda create -n ${condaJlEnv} python=${pythonVersion}
  '';

  fhsCommand = commandName: commandScript:
    pkgs.buildFHSUserEnv {
      targetPkgs = targetPkgs;
      name = commandName; # Name used to start this UserEnv
      multiPkgs = multiPkgs;
      runScript = commandScript;
      extraOutputsToInstall = extraOutputsToInstall;
      profile = envvars;
    };

in fhsCommand
