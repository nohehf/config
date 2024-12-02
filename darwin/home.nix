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
  imports = [
    ./dock
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    # masApps = {
    #   "1password" = 1333542190;
    #   "wireguard" = 1451685025;
    # };
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
        programs =
          { }
          // import ../programs.nix {
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
    # { path = "/Applications/Slack.app/"; }
    { path = "/System/Applications/Messages.app/"; }
    # { path = "/System/Applications/Facetime.app/"; }
    # { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
    # { path = "${pkgs.visual-studio-code}"; } // todo find vscode path
    # { path = "/System/Applications/Music.app/"; }
    # { path = "/System/Applications/News.app/"; }
    # { path = "/System/Applications/Photos.app/"; }
    # { path = "/System/Applications/Photo Booth.app/"; }
    # { path = "/System/Applications/TV.app/"; }
    # { path = "/System/Applications/Home.app/"; }
    {
      path = "${config.users.users.${user}.home}/.local/share/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "${config.users.users.${user}.home}/.local/share/downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];

}
