{ config, lib, pkgs, ... }:
let
in {
  imports = [ ../common.nix ];
  neovim.enable = true;

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
