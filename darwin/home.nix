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
  HOME = "/Users/${user}";
  # Import SyncThing device configuration from gitignored secrets file
  # This file may not exist, so we handle it gracefully
  syncthingDevices = let
    secretsPath = ../secrets/syncthing-devices.nix;
  in
    if builtins.pathExists secretsPath then import secretsPath else { devices = {}; };
  # Extract device names from the secrets file for use in folder configurations
  deviceNames = builtins.attrNames syncthingDevices.devices;
in
{
  imports = [ ./dock ];

  users.users.${user} = {
    name = "${user}";
    home = HOME;
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
    ];
    casks = pkgs.callPackage ./casks.nix { };

    brews = [
      "coreutils"
      "awscli" # awscli2. install via nixpkgs is kind of broken.
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
          packages = import ./packages.nix { inherit pkgs; };
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

        services.syncthing = {
          enable = true;
          guiAddress = "127.0.0.1:8384";
          # Override all settings set from the GUI. This is necessary to avoid changes made from the GUI apply.
          overrideDevices = true;
          overrideFolders = true;

          settings = {
            # Devices are imported from gitignored secrets file
            devices = syncthingDevices.devices;

            folders = {
              "notes" = {
                # The ID of a folder you'd like to sync
                label = "notes"; # Optional device-specific folder name
                path = "${HOME}/notes/";
                # Share with all devices from secrets file
                devices = deviceNames;
              };
              "sync" = {
                # The ID of a folder you'd like to sync
                label = "sync"; # Optional device-specific folder name
                path = "${HOME}/sync/";
                # Share with all devices from secrets file
                devices = deviceNames;
              };
            };
          };
        };
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

  nix = {
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };
}
