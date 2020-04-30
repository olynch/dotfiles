{ config, lib, pkgs, ... }:

pkgs.python38.withPackages (ps: with ps; [
  numpy
  scipy
  scikitlearn
  matplotlib
  seaborn
  jupyterlab
  jupyterlab_server
  jupyterlab_launcher
  ipython
  ipywidgets
  pandas
  mypy
])
