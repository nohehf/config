# todo distro specific stuff
# plan is to generate a single binary at install (or activation) via home manager, that contains system info and run ... #.{system}.{}...
switch:
   nix run .#switch

build:
    nix run .#build
