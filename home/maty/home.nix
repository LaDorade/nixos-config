{ config, lib, pkgs, mainUser, ... }:
let username = mainUser;
in {
  imports = [
    ../common.nix
    ../modules/neovim.nix
    ../modules/dev.nix
    ../modules/fish
    ../modules/ghostty.nix
    ../modules/mangohud.nix
  ];
  neovim.enable  = true;
  devEnvs = {
    enable = true;
    rustEnv.enable = true;
    odinEnv.enable = true;
    zigEnv.enable  = true;
    haskellEnv.enable = true;
  };

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;
  programs.zed-editor.enable = true;
  programs.ghostty.package = pkgs.ghostty;

  home.packages = with pkgs; [
    # GUI
    discord

    # CLI
    unzip
    file
  ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
