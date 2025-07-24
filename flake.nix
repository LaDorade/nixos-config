{
  description = "Configuration NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
        url = "github:nix-community/nixvim/nixos-25.05";
        #url = "github:nix-community/nixvim";        # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, nixvim, ... }@inputs:
    let lib = nixpkgs.lib;
    in {
      nixosConfigurations = let
        mkNixosSystem = { hostname, username, system ? "x86_64-linux", }:
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
                home-manager.useUserPackages = true;
                home-manager.users.${username} = import ./home/${username}/home.nix;
                home-manager.backupFileExtension = "backup";
		home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
                home-manager.extraSpecialArgs = {
                  mainUser = username;
                  hostName = hostname;
                };
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
      darwinConfigurations = {
        "mini-blg" = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./darwin/mini-blg/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."matysse_blg" = import ./home/matysse_blg/home.nix;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };
      };
    };
}
