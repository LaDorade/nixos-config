{ config, lib, pkgs, mainUser, ... }:
let username = mainUser;
in {
  imports = [
    ../common.nix
    ../modules/dev.nix
    ../modules/fish
  ];
  nixvim.enable = true;
  devEnvs.enable = true;
  devEnvs.nodeEnv.enable = true;
  devEnvs.rustEnv.enable = true;

  home.username = username;
  #home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # CLI
    unzip
    file
  ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
