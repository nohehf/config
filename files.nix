{ pkgs, config, ... }:
let
  HOME = config.home.homeDirectory;
  CONFIG = "${HOME}/config/config";
  CODE = "${HOME}/Library/Application Support/Code/User";
  mksym = config.lib.file.mkOutOfStoreSymlink;
in
{
  "${CODE}/settings.json".source = mksym "${CONFIG}/vscode/settings.json";
  "${CODE}/keybindings.json".source = mksym "${CONFIG}/vscode/keybindings.json";
  "${HOME}/.gitconfig".source = mksym "${CONFIG}/.gitconfig";
  "${HOME}/.gitignore".source = mksym "${CONFIG}/.gitignore";
  "${HOME}/.githelpers".source = mksym "${CONFIG}/.githelpers";
  "${HOME}/.starship.toml".source = mksym "${CONFIG}/.starship.toml";
  "${HOME}/.zshrc".source = mksym "${CONFIG}/.zshrc";
  "${HOME}/lib.sh".source = mksym "${CONFIG}/lib.sh";
  "${HOME}/.config/starship.toml".source = mksym "${CONFIG}/.starship.toml";
  "${HOME}/.config/nvim".source = mksym "${CONFIG}/nvim";

  # TODO: manage secrets properly
  "${HOME}/.secrets".source = mksym "${HOME}/config/secrets";
}
