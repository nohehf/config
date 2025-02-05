# Apps will create runnable binaries via nix run .#<app-name> targeted to the right specific system
# They are used to target the correct scripts in the bin folder
{
  nixpkgs,
  self,
}:
let
  mkApp = scriptName: system: {
    type = "app";
    program = "${
      (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
        #!/usr/bin/env bash
        PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
        echo "Running ${scriptName} for ${system}"
        exec ${self}/bin/${system}/${scriptName}
      '')
    }/bin/${scriptName}";
  };
  mkApps = system: {
    "build" = mkApp "build" system;
    "switch" = mkApp "switch" system;
    "rollback" = mkApp "rollback" system;
  };
in
{
  "aarch64-darwin" = mkApps "aarch64-darwin";
  "x86_64-linux" = mkApps "x86_64-linux";
}
