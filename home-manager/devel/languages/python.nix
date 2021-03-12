{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python-language-server
    (python38.withPackages (ps:
      with ps; [
        # Scientific Libraries

        ## Standard
        numpy
        scipy
        matplotlib
        pandas
        scikitlearn

        ## More exotic
        statsmodels # Says it on the tin
        seaborn # pretty graphs with data frames
        sympy # symbolic math
        xarray # if numpy and pandas had a baby...

        # Jupyter and Friends
        jupyter
        jupyterlab
        jupyterlab_server
        jupyterlab_launcher
        jupyter-repo2docker
        ipython
        ipywidgets

        # Dev Packages
        mypy # typing
        debugpy # debugging
        black # formatting
        pyflakes # testing
        isort # import sorting
        pytest # testing
        nose # testing
      ]))
  ];
}
