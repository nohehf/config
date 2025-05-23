{
  config,
  pkgs,
  lib,
  home-manager,
  user,
  email,
  ...
}:

let
  HOME = builtins.getEnv "HOME";
in
{
  imports = [ ./dock ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # TODO: enable cleanup once migration ready
      cleanup = "uninstall";
    };

    taps = [
      "nikitabobko/tap" # for aerospace
      "homebrew/homebrew-cask" # seems to be needed as https://github.com/zhaofengli/nix-homebrew is broken as hell
    ];
    casks = pkgs.callPackage ./casks.nix { };

    brews = [
      "coreutils"
    ];
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage ./packages.nix { };
          file = import ./files.nix { inherit config pkgs; } // import ../files.nix { inherit config pkgs; };
          stateVersion = "23.11";
        };
        programs = import ../programs.nix {
          inherit
            config
            pkgs
            lib
            user
            email
            ;
        };

        # Marked broken Oct 20, 2022 check later to remove this
        # https://github.com/nix-community/home-manager/issues/3344
        manual.manpages.enable = false;
      };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Google Chrome.app"; }
    { path = "/Applications/WezTerm.app"; }
    # { path = "/Applications/Cursor.app"; }
    { path = "/Applications/Bitwarden.app"; }
    { path = "/Applications/Notion.app"; }
    { path = "/Applications/Discord.app"; }
  ];

}
