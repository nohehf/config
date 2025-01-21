{
  config,
  pkgs,
  lib,
  user,
  email,
  ...
}:

let
  name = user;
in
{
  vim = import ./config/vim.nix {
    inherit
      config
      pkgs
      lib
      name
      email
      ;
  };

  wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ./config/.wezterm.lua;
  };

  # Atuin managed by home-manager
  atuin = {
    enable = true;
    settings = {
      style = "compact";
      inline_height = 40;
    };
  };

  # Zsh, install plugins then load from ~/.zshrc that will be symlinked
  zsh = {
    enable = true;

    # Store it in an other path to keep ~/.zshrc
    dotDir = ".config/zsh-home-manager";

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
    initExtra = ''
      if [ -f "$HOME/.zshrc" ]; then
        source "$HOME/.zshrc"
      fi
    '';
  };
}
