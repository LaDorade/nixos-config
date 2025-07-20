{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;
in {
  options.devEnvs = {
    enable = mkEnableOption "Global dev env";
    rustEnv.enable = mkEnableOption "Rust dev environment";
    jsEnv.enable = mkEnableOption "Js node dev environment";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; mkIf cfg.rustEnv.enable [
      rustc
      cargo
      clippy
      rust-analyzer
      rustfmt
    ];
  };
}

