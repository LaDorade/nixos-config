{
  description = "Configuration NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
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

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let 
      lib = nixpkgs.lib;
      
      # Import des modules de configuration
      darwinModule = import ./darwin-flake.nix { inherit inputs lib; };
      nixosModule  = import ./nixos-flake.nix  { inherit inputs lib; };
      wslModule    = import ./wsl-flake.nix    { inherit inputs lib; };
    in 
      # Merge des configurations Darwin et NixOS
      darwinModule // nixosModule // wslModule;
}
