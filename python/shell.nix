# shell.nix
{ pkgs ? import <nixpkgs> {} }:
let
  my-python = pkgs.python3Full;
  python-with-my-packages = my-python.withPackages (p: with p; [
    requests
    # other python packages you want
    pygobject3
    pkgs.networkmanager
  ]);
in
pkgs.mkShell {
  buildInputs = [
    python-with-my-packages
    # other dependencies
    pkgs.networkmanager
  ];
  shellHook = ''
    PYTHONPATH=${python-with-my-packages}/${python-with-my-packages.sitePackages}
    # maybe set more env-vars
  '';
}
