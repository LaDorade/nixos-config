{ inputs, lib, ... }:

let
  mkWslSystem = { hostname, username, system ? "x86_64-linux" }:
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
	      inputs.nixos-wsl.nixosModules.default
	      {
          system.stateVersion = "25.05";
          wsl.enable = true;
	        wsl.defaultUser = username;
        }
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
    "wsl-maty" = mkWslSystem {
      hostname = "wsl-maty";
      username = "wsl-maty";
    };
  };
}
