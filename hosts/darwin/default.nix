{ config, pkgs, user, ... }:

let
  HOME = config.users.users.${user}.home;
in

{
  imports = [
    ../../modules/darwin/home.nix
  ];

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.checks.verifyNixPath = false;

  environment.systemPackages = with pkgs; [
  ] ++ (import ../../packages.nix { inherit pkgs; });

  # enable sudo touch id auth
  security.pam.enableSudoTouchIdAuth = true;

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 15; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        autohide-time-modifier = 0.2;
        autohide-delay = 0.0;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";

        # does not exist apprently
        # size-immutable = true;
        tilesize = 35;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        AppleShowAllFiles = true;

        # bottom status bar
        ShowStatusBar = true;
        ShowPathbar = true;

        # default to list view
        FXPreferredViewStyle = "Nlsv";
      };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
      trackpad = {
        Clicking = true;
      };

      CustomUserPreferences = {
        # custom iterm config
        "com.googlecode.iterm2" = {
          PrefsCustomFolder = "${HOME}/config/config/iterm";
          LoadPrefsFromCustomFolder = true;
        };

      };
    };
  };
}
