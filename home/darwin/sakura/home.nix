{
  # config,
  # lib,
  pkgs,
  # mainUser,
  ...
}:
let
in
{
  imports = [
    ../common.nix
    ../../modules/emacs.nix
    ../../modules/obsidian.nix
    ../../modules/dev.nix
    ../../modules/neovim.nix
  ];

  neovim = {
    enable  = true;
    useLsps = true;
  };

  devEnvs = {
    enable         = true; # Enable global dev environment
    phpEnv.enable  = true;
    nodeEnv.enable = true;
    rustEnv.enable = true;
    goEnv.enable   = true;
    zigEnv.enable  = true;
    odinEnv.enable = true;
    haskellEnv.enable = true;
  };

  home.packages = with pkgs; [
    yt-dlp
  ];

  # https://home-manager-options.extranix.com/?query=programs.nh.flake&release=master
  programs.nh.flake = "/Users/sakura/Documents/Code/nix/nixos-config";

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
