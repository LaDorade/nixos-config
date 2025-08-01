# Module Darwin pour les configurations macOS
{ inputs, lib, ... }:

let
  mkDarwinSystem = { hostname, username, system ? "aarch64-darwin" }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit inputs lib;
        mainUser = username;
        hostName = hostname;
      };
      modules = [
        ./hosts/darwin/${hostname}/configuration.nix
        inputs.mac-app-util.darwinModules.default
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} =
            import ./home/darwin/${username}/home.nix;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [
            inputs.nixvim.homeModules.nixvim
            inputs.mac-app-util.homeManagerModules.default
          ];
          home-manager.extraSpecialArgs = {
            mainUser = username;
            hostName = hostname;
          };
        }
        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            user = username;
            enable = true;
            enableRosetta = true;
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
              "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
            };
            mutableTaps = false;
            autoMigrate = true;
          };
        }
      ];
    };
in
{
  darwinConfigurations = {
    "mini-blg" = mkDarwinSystem {
      hostname = "mini-blg";
      username = "matysse_blg";
    };
    "matypro" = mkDarwinSystem {
      hostname = "matypro";
      username = "sakura";
    };
  };
}
