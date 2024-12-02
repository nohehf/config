{ config, pkgs, user, ... }:

let
  HOME = config.users.users.${user}.home;
in

{
  imports = [
    ./home.nix
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

  # mac-os specifig packages
  environment.systemPackages = with pkgs; [
  ] ++ (import ../packages.nix { inherit pkgs; });

  # fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  # enable sudo touch id auth
  security.pam.enableSudoTouchIdAuth = true;

  system = {
    stateVersion = 4;

    # nice ressource: <https://macos-defaults.com/>
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

        # Search current folder
        FXDefaultSearchScope = "SCcf";
        # Column view by default
        FXPreferredViewStyle = "clmv";

        # bottom status bar
        ShowStatusBar = true;
        ShowPathbar = true;
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

        # custom keyboard layout
        "com.apple.HIToolbox" = {
          AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keyboardlayout.qwerty-fr.keylayout.qwerty-fr";
          AppleEnabledInputSources = [
            {
              "Bundle ID" = "com.apple.CharacterPaletteIM";
              InputSourceKind = "Non Keyboard Input Method";
            }
            {
              "Bundle ID" = "com.apple.PressAndHold";
              InputSourceKind = "Non Keyboard Input Method";
            }
          ];
          AppleFnUsageType = 2;
          AppleInputSourceHistory = [
            {
              InputSourceKind = "Keyboard Layout";
              "KeyboardLayout ID" = "-7247";
              "KeyboardLayout Name" = "qwerty-fr";
            }
          ];
          AppleSelectedInputSources = [
            {
              "Bundle ID" = "com.apple.PressAndHold";
              InputSourceKind = "Non Keyboard Input Method";
            }
            {
              InputSourceKind = "Keyboard Layout";
              "KeyboardLayout ID" = "-7247";
              "KeyboardLayout Name" = "qwerty-fr";
            }
          ];
        };
      };
    };
  };
}
