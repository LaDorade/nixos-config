{ config, lib, pkgs, osConfig, ... }:
let
in {
  imports = [
    ../common.nix
    ../../modules/fish
    ../../modules/kitty.nix
    ../../modules/utils.nix
    ../../modules/vscode.nix
    ../../modules/dev.nix
  ];

  devEnvs = {
    enable = true; # Enable global dev environment
    phpEnv.enable = true; # Enable PHP dev environment
    nodeEnv.enable = true; # Enable Node.js dev environment
  };

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
