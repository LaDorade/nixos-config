{ config, lib, pkgs, osConfig, ... }:
let
in {
  imports = [
    ../../modules/kitty.nix
    ../../modules/fish
  ];
  home.packages = with pkgs; [
    neovim
    ripgrep
    fastfetch
    htop
  ];

  # Pour générer les fichiers de configuration dans ~/.config
  xdg.enable = true;

  programs.home-manager.enable = true;
  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
