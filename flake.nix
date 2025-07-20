{
  description = "Configuration NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Optionnel : pour formatter
    nixpkgs-fmt.url = "github:nix-community/nixpkgs-fmt";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations."nix-maty" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs lib;};
      modules = [
        ./hosts/nix-maty/configuration.nix
        home-manager.nixosModules.home-manager
        {
	  home-manager.useGlobalPkgs = true;
          home-manager.users.maty = import ./home/maty/home.nix;
	  home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}

