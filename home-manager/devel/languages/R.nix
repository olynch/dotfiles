{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (rWrapper.override {
      packages = with pkgs.rPackages; [
        # Core Tidyverse
        tidyverse

        # Visualization
        cowplot

        # Finance
        tidyquant
        tsibble

        # Statistics
        parsnip
        yardstick
        kknn
        kernlab
        rstan

        # Web apps
        shiny
        rsconnect

        # Rethinking
        (buildRPackage {
          name = "rethinking";
          src = pkgs.fetchFromGitHub {
            owner = "rmcelreath";
            repo = "rethinking";
            rev = "f393f30dbaba3f5e41dd003c2bfefcb67c235bb9";
            sha256 = "138k8dhsmkmy1zc0rl2fyf2y2rk3f4ck9j3rz45w5rvfvk2arzf4";
          };
          propagatedBuildInputs = [ coda MASS mvtnorm loo shape rstan dagitty ];
        })
      ];
    })
  ];
}
