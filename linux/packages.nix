{ pkgs }:

with pkgs;
let
  shared-packages = import ../packages.nix { inherit pkgs; };
in
shared-packages
++ [
  docker
  kubectl
  unzip

  # gcc is used by nvim, to compile fzf native
  # Todo: it would be better to wrap nvim in nix to provide gcc or directly fzf native
  gcc
  # clang
]
