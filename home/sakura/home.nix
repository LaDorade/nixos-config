{ config, lib, pkgs, osConfig, ... }:
let
in {
  imports = [ ../modules/kitty.nix ../modules/fish ../common.nix ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
