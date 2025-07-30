{ config, lib, pkgs, osConfig, ... }:
let
in {
  imports = [
    ../common.nix
    ../../fish
    ../../modules/kitty.nix
  ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
