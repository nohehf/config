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

}
