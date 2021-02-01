{ config, lib, pkgs, ... }:

pkgs.python38.withPackages (ps: with ps; [
  numpy
  scipy
  scikitlearn
  matplotlib
  seaborn
  jupyter
  jupyterlab
  jupyterlab_server
  jupyterlab_launcher
  jupyter-repo2docker
  ipython
  ipywidgets
  pandas
  mypy
  sympy
  debugpy
  black
  pyflakes
  isort
  pytest
  nose
])
