# TODO: prefer syntax from ./packages.nix
{ pkgs, config, ... }:
let
  HOME = config.home.homeDirectory;
  CONFIG = "${HOME}/config/config";
  mksym = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Add host specific symlinks here
}
