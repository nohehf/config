{
  pkgs,
  headless ? false,
}:

with pkgs;
[
  # Docker management
  docker
  docker-credential-helpers
  docker-buildx
  kubectl
  colima
  lazydocker
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
  jq
  tree
  ## github cli, convinent to create repos
  gh
  starship
  fzf
  zsh-syntax-highlighting
  zsh-autosuggestions
  helix
  fastfetch
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

  awscli2
  k9s
]
++ (
  if !headless then
    [
      # headfull only
      obsidian
    ]
  else
    [
      # headless only
    ]
)
