{
  config,
  lib,
  pkgs,
  mainUser,
  ...
}:
let
in
{
  imports = [
    ../common.nix
    ../../modules/obsidian.nix
    ../../modules/dev.nix
    ../../modules/vscode.nix
    ../../modules/kitty.nix
  ];

  nixvim.enable = true;

  devEnvs = {
    enable         = true; # Enable global dev environment
    phpEnv.enable  = true;
    nodeEnv.enable = true;
    rustEnv.enable = true;
    goEnv.enable   = true;
    zigEnv.enable  = true;
  };

  home.packages = with pkgs; [
    mosquitto
    yt-dlp
    emacs
    
    # c3c, problem with fish completions
    
    # debugging tools
    lldb
  ];

  # https://home-manager-options.extranix.com/?query=programs.nh.flake&release=master
  programs.nh.flake = "/Users/sakura/Documents/Code/nix/nixos-config";

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
