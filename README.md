# nohehf nix based config

> ⚠️ This is a WIP. While Darwin works well, nixos is currently broken.

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
- support linux (nixOS) -> make it actually work
- support a "only install tools" config. Ie. via nix (very usefull when I use a vm or some computer via ssh and I just want to install some tools like nvim with my config)

## Keybinds / modifiers rationnale

~~Windows (aerospace): ALT (+ SHIFT) -> this needs to be changed, cf. TODOs
Open apps (raycast): HYPER -> this needs to be fixed or changed, as it will not only open but focus existing windows, I just want to start them.
Terminal panes: CMD + OPTION -> This should be only command I believe. Need to make it feel like aerospace too.~~

TODO: rewrite this

## Nvim

### TODOS

- Add a file viewer and / or oil.nvim -> I feel that it is kind of hard for me to visualise the project / workspace for now
