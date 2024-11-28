{ pkgs, config, ... }:
let
  HOME = builtins.getEnv "HOME";
in
{
  "${HOME}/Library/Application Support/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink ./config/vscode/settings.json;
  "${HOME}/Library/Application Support/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink ./config/vscode/keybindings.json;
}
