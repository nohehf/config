# nohehf nix based config

> ⚠️ This is a WIP. Darwin works but is not well documented, nixos is currently broken.

files.nix -> creates symlinks to given files (to manage actual dotfiles)
flake.nix -> entry point
packages.nix -> declarative list of packages to install from nixpkgs
programs.nix -> declarative configuration of packages (home-manager global programs definition)
./config -> contains nix files and dotfiles for configurating programs

## run

/!\ make shure to git add before running

just test the build:
`nix run .#build`

apply the new switch
`rix run .#build-switch`

## acknoledgments

This is based on: <https://github.com/dustinlyons/nixos-config>

## TODO

- secret management
- merge host and modules to simplify structure
- add install script
