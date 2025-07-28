{ config, lib, pkgs, ... }:
let
in {
  imports = [
    ../common.nix
  ];

  home.username = "pi";
  home.homeDirectory = "/home/pi";
  home.packages = with pkgs; [
    curl
    unzip
    file
  ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
