{ pkgs, config, ... }:
let
  HOME = builtins.getEnv "HOME";
  CONFIG = "${HOME}/config/config";
in
{
  "${HOME}/Library/Application Support/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/Users/nohehf/config/config/vscode/settings.json";
  "${HOME}/Library/Application Support/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${CONFIG}/vscode/keybindings.json";
}
