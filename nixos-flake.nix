# Module NixOS pour les configurations Linux
{ inputs, lib, ... }:

let
  mkNixosSystem = { hostname, username, system ? "x86_64-linux" }:
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs lib system;
        mainUser = username;
        hostName = hostname;
      };
      modules = [
        ./configs/nixos/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} =
            import ./home/${username}/home.nix;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [ inputs.nixvim.homeModules.nixvim ];
          home-manager.extraSpecialArgs = {
            mainUser = username;
            hostName = hostname;
          };
        }
      ];
    };
in
{
  nixosConfigurations = {
    "maty" = mkNixosSystem {
      hostname = "maty";
      username = "maty";
    };
    "lenovo-laptop" = mkNixosSystem {
      hostname = "lenovo-laptop";
      username = "lenovo";
    };
    "acer-laptop" = mkNixosSystem {
      hostname = "acer-laptop";
      username = "acer";
    };
    "pi" = mkNixosSystem {
      hostname = "pi";
      username = "pi";
      system = "aarch64-linux";
    };
  };
}
