{
  description = "Shared Configuration for MacOS and NixOS, initially based on https://github.com/dustinlyons/nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      darwin,
      home-manager,
      nixpkgs,
    }@inputs:
    let
      user = "nohehf";
      email = "nohe.hinniger.foray@gmail.com";
    in
    {
      nixpkgs = {
        config = {
          allowUnfree = true;
          allowBroken = true;
          allowInsecure = false;
          allowUnsupportedSystem = true;
        };
      };

      apps = import ./apps.nix { inherit nixpkgs self; };

      # ARM OSX
      # TODO: move this out of the flake root
      darwinConfigurations =
        let
          system = "aarch64-darwin";
        in
        {
          ${system} = darwin.lib.darwinSystem {
            inherit system;
            specialArgs = {
              inherit
                user
                email
                inputs
                ; # Pass user, email, and inputs to the module
            };
            modules = [
              home-manager.darwinModules.home-manager
              ./darwin/host.nix
            ];
          };
        };

      # non nix OS linux home manager
      homeConfigurations =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs { inherit system; };
        in
        {
          "${system}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./linux/home.nix ];
            extraSpecialArgs = {
              inherit inputs user email;
              headless = builtins.getEnv "DISPLAY" == "";
            };
          };
          # headfull should be added here when necessary (to enable GUI apps)
        };
    };
}
