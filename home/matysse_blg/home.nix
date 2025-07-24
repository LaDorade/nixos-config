{ config, lib, pkgs, osConfig, ... }:
let
in {
  home.packages = with pkgs; [ neovim ripgrep fastfetch ];

  # Pour générer les fichiers de configuration dans ~/.config
  xdg.enable = true;

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
