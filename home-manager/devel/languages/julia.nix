{ config, lib, pkgs, ... }:

with lib;
let cfg = config.programs.scientific-fhs;
in {
  options.programs.scientific-fhs = {
    enable = mkEnableOption "an FHS for science!";

    juliaVersions = mkOption {
      type = types.listOf (types.submodule {
        options = {
          version = mkOption {
            type = types.str;
            default = "julia_16";
          };
          default = mkOption {
            type = types.bool;
            default = false;
          };
        };
      });
      default = [{
        version = "julia_16";
        default = true;
      }];
    };

    enableNVIDIA = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = {
    home.packages = builtins.concatMap (version-spec:
      let
        fhsCommand = pkgs.callPackage ./scientific-fhs {
          enableNVIDIA = cfg.enableNVIDIA;
          juliaVersion = version-spec.version;
        };
        name = if version-spec.default then "julia" else version-spec.version;
        python = if version-spec.default then [
          (fhsCommand "python3" "python3")
          (fhsCommand "python" "python3")
        ] else
          [ ];
      in [ (fhsCommand name "julia") (fhsCommand "${name}-bash" "bash") ]
      ++ python) cfg.juliaVersions;
  };
}
