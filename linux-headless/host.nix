{
  config,
  pkgs,
  user,
  ...
}:

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
      trusted-users = [
        "@admin"
        "${user}"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.checks.verifyNixPath = false;

  environment.systemPackages = import ../packages.nix { inherit pkgs; };
}
