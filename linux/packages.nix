{ pkgs }:

with pkgs;
let
  shared-packages = import ../packages.nix { inherit pkgs; };
in
shared-packages
++ [
  docker
  kubectl
]
