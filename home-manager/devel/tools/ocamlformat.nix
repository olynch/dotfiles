self: super:
{
  emacsPackagesNg.ocamlformat = super.emacsPackagesNg.trivialBuild {
    pname = "ocamlformat";
    version = super.ocamlPackages.ocamlformat.version;

    phases = [ "buildPhase" "installPhase" ];

    buildPhase = ''
      cp ${super.ocamlPackages.ocamlformat}/share/emacs/site-lisp/*.el .
    '';
  };
}
