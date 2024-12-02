# TODO: prefer syntax from ./packages.nix
{ pkgs, config, ... }:
let
  HOME = config.home.homeDirectory;
  CONFIG = "${HOME}/config/config";
  CODE = "${HOME}/Library/Application Support/Code/User";
  mksym = config.lib.file.mkOutOfStoreSymlink;
in
{
  # TODO: mac os only files
}
