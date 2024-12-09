{ pkgs }:

with pkgs;
[
  # General tools
  fastfetch
  neovim
  bat
  ripgrep
  btop
  git
  wget

  fzf
  # atuin
  helix

  # Fonts
  jetbrains-mono

  # Language tools
  ## Nix
  nixpkgs-fmt
  nixfmt-rfc-style # nixfmt
  nil
  nixd
]
