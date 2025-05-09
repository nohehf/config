# TODO: prefer syntax from ./packages.nix
{ pkgs, config, ... }:
let
  HOME = config.home.homeDirectory;
  CONFIG = "${HOME}/config/config";
  CODE = "${HOME}/Library/Application Support/Code/User";
  mksym = config.lib.file.mkOutOfStoreSymlink;
in
{
  "${HOME}/.config/karabiner".source = mksym "${CONFIG}/karabiner";
  "${HOME}/.config/aerospace".source = mksym "${CONFIG}/aerospace";
}
