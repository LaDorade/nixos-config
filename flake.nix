{
  description = "Configuration NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Nix-Homebrew simply installs Homebrew
    nix-homebrew = { url = "github:zhaofengli-wip/nix-homebrew"; };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      #url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, nixvim, nix-homebrew, ...
    }@inputs:
    let lib = nixpkgs.lib;
    in {
      nixosConfigurations = let
        mkNixosSystem =
          { hostname, username, system ? "x86_64-linux", full ? true }:
          lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs lib;
              mainUser = username;
              hostName = hostname;
            };
            modules = [
              ./hosts/nixos/${hostname}/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} =
                  import ./home/${username}/home.nix;
                home-manager.backupFileExtension = "backup";
                home-manager.sharedModules = [ ]
                  ++ lib.optionals full [ nixvim.homeModules.nixvim ];
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
        "nix-pi" = mkNixosSystem {
          hostname = "nix-pi";
          username = "pi";
          system = "aarch64-linux";
          full = false;
        };
      };
      darwinConfigurations = let
        mkDarwinSystem = { hostname, username, system ? "aarch64-darwin"
          , enableHomebrew ? false }:
          nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = {
              inherit inputs lib;
              mainUser = username;
              hostName = hostname;
            };
            modules = [
              ./hosts/darwin/${hostname}/configuration.nix
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} =
                  import ./home/${username}/home.nix;
                home-manager.backupFileExtension = "backup";
                home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
                home-manager.extraSpecialArgs = {
                  mainUser = username;
                  hostName = hostname;
                };
              }
            ] ++ lib.optionals enableHomebrew [
              nix-homebrew.darwinModules.nix-homebrew
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
      in {
        "mini-blg" = mkDarwinSystem {
          hostname = "mini-blg";
          username = "matysse_blg";
        };
        "matypro" = mkDarwinSystem {
          hostname = "matypro";
          username = "sakura";
          enableHomebrew = true;
        };
      };
    };
}
