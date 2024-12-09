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
}
