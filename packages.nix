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
  gnupg

  starship
  fzf
  zsh-syntax-highlighting
  zsh-autosuggestions

  helix

  # Language tools
  ## Nix
  nixpkgs-fmt
  nixfmt-rfc-style # nixfmt
  nil
  nixd

  ## lua
  stylua

  ## go
  go
  gopls

  ## python
  uv
  python313
  python313Packages.black
  python313Packages.ruff

  ## js / ts
  volta

  ## rust
  rustup

  ## github cli, convinent to create repos
  gh
]
