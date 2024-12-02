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

  # Fonts
  jetbrains-mono

  # Language tools
  ## Nix
  nixpkgs-fmt
  nixfmt-rfc-style # nixfmt
  nil
  nixd
]
