# Module NixOS pour les configurations Linux
{ inputs, lib, ... }:

let
  mkNixosSystem = { hostname, username, system ? "x86_64-linux", full ? true }:
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs lib;
        mainUser = username;
        hostName = hostname;
      };
      modules = [
        ./hosts/nixos/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} =
            import ./home/${username}/home.nix;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [ ]
            ++ lib.optionals full [ inputs.nixvim.homeModules.nixvim ];
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
    "nix-maty" = mkNixosSystem {
      hostname = "nix-maty";
      username = "maty";
    };
    "lenovo-laptop" = mkNixosSystem {
      hostname = "lenovo-laptop";
      username = "lenovo";
    };
    "nix-pi" = mkNixosSystem {
      hostname = "nix-pi";
      username = "pi";
      system = "aarch64-linux";
      full = false;
    };
  };
}
