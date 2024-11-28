{ pkgs, config, ... }:
let
  HOME = config.home.homeDirectory;
  CONFIG = "${HOME}/config/config";
  CODE = "${HOME}/Library/Application Support/Code/User";
  mksym = config.lib.file.mkOutOfStoreSymlink;
in
{
  "${CODE}/settings.json".source = mksym "${CONFIG}/vscode/settings.json";
  "${CODE}//keybindings.json".source = mksym "${CONFIG}/vscode/keybindings.json";
}
