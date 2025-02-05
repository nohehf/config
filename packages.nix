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
  just
  ## github cli, convinent to create repos
  gh
  starship
  fzf
  zsh-syntax-highlighting
  zsh-autosuggestions
  helix

  # Language tools
  ## Nix
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

]
