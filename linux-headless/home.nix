{
  config,
  pkgs,
  lib,
  home-manager,
  user,
  email,
  ...
}:
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

}
