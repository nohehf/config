{
  config,
  pkgs,
  lib,
  user,
  email,
  headless ? false,
  ...
}:
let
  shared-programs = import ../programs.nix {
    inherit
      config
      pkgs
      lib
      user
      email
      headless
      ;
  };

  shared-files = import ../files.nix { inherit config pkgs; };
in
{

  # todo: default shell
  #   shell = pkgs.zsh;

  home = {
    username = user;
    homeDirectory = "/home/${user}";

    packages = pkgs.callPackage ./packages.nix { };

    file = { } // shared-files;

    # Set zsh as default shell on activation
    activation.make-zsh-default-shell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # if zsh is not the current shell
        PATH="/usr/bin:/bin:$PATH"
        ZSH_PATH="/home/${user}/.nix-profile/bin/zsh"
        if [[ $(getent passwd ${user}) != *"$ZSH_PATH" ]]; then
          echo "setting zsh as default shell (using chsh). password might be necessay."
          if grep -q $ZSH_PATH /etc/shells; then
            echo "adding zsh to /etc/shells"
            run echo "$ZSH_PATH" | sudo tee -a /etc/shells
          fi
          echo "running chsh to make zsh the default shell"
          run chsh -s $ZSH_PATH ${user}
          echo "zsh is now set as default shell !"
        fi
    '';

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;

    # other distro specific programs here
  } // shared-programs;
}
