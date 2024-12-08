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

Aerospace:
- Bootstrap workspaces scripts (go to browser workspace and open browser if not present) 

- Fix keybinds: layout (qwerty-fr) and aerospace overlaps (alt + 8 for insance).

## Keybinds / modifiers rationnale

Windows (aerospace): ALT (+ SHIFT) -> this needs to be changed, cf. TODOs
Open apps (raycast): HYPER -> this needs to be fixed or changed, as it will not only open but focus existing windows, I just want to start them.
Terminal panes: CMD + OPTION -> This should be only command I believe. Need to make it feel like aerospace too.

### Thinking:

Maybe re mapping HYPER to: cmd + option + ctrl and using it as main modifier for aerospace would be nice (HYPER + SHIFT to move windows)
Tho that would mean removing the mapping for launching apps (ie. HYPER + T would move to the Terminal workspace).
HOWEVER, I think the only apps i really need to start on the fly are browser and terminal. Clipboard access is nice too.
