{
  description = "Configuration NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Optionnel : pour formatter
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = let
      mkNixosSystem = {
        hostname,
        username,
        system ? "x86_64-linux",
      }:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
	    inherit inputs lib;
	    mainUser = username;
	    hostName = hostname;
	  };
          modules = [
            ./hosts/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home/${username}/home.nix;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
    in {
      "nix-maty" = mkNixosSystem {
        hostname = "nix-maty";
        username = "maty";
      };
      "lenovo-laptop" = mkNixosSystem {
        hostname = "lenovo-laptop";
        username = "lenovo";
      };
    };
  };
}
