{
  config,
  pkgs,
  lib,
  user,
  email,
  headless ? false,
  ...
}:

let
  name = user;
in
{
  wezterm = {
    enable = !headless; # only install on headfull hosts
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ./config/.wezterm.lua;
  };

  # Atuin managed by home-manager
  atuin = {
    # disable for now on headless, see: https://github.com/atuinsh/atuin/issues/2438
    enable = !headless;
    settings = {
      style = "compact";
      inline_height = 40;
    };
  };

  # Zsh, install plugins then load from ~/.zshrc that will be symlinked
  zsh = {
    enable = true;

    # Store it in an other path to keep ~/.zshrc
    dotDir = "${config.xdg.configHome}/zsh-home-manager";

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Enable Antidote and configure plugins
    antidote = {
      enable = true;
      plugins = [
        "getantidote/use-omz" # handle OMZ dependencies
        "ohmyzsh/ohmyzsh path:lib" # load OMZ's library
        "ohmyzsh/ohmyzsh path:plugins/docker-compose"
      ];
    };

    # Source the existing ~/.zshrc dynamically
    initContent = ''
      if [[ "$(uname -m)" == "arm64" ]]; then
            # Make sure brew is in env on arm
            eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      if [ -f "$HOME/.zshrc" ]; then
        source "$HOME/.zshrc"
      fi
    '';
  };
}
