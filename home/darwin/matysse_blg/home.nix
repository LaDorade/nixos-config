{ config, lib, pkgs, osConfig, home, ... }:
let
in {
  imports = [
    ../common.nix
    ../../modules/fish
    ../../modules/kitty.nix
    ../../modules/vscode.nix
    ../../modules/dev.nix
  ];

  programs.zen-browser.enable = true;

  devEnvs = {
    enable = true; # Enable global dev environment
    phpEnv.enable = true; # Enable PHP dev environment
    nodeEnv.enable = true; # Enable Node.js dev environment
    rustEnv.enable = true;
    zigEnv.enable = true;
  };

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
