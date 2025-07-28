{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;

  commonPackages = with pkgs; [
  ];
  rustPackages = with pkgs; [
    rustup
  ];
  nodePackages = with pkgs; [
    nodejs_24
    yarn
  ];
in {
  options.devEnvs = {
    enable = mkEnableOption "Global dev env";
    rustEnv.enable = mkEnableOption "Rust dev environment";
    jsEnv.enable = mkEnableOption "Js node dev environment";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      commonPackages
      ++ lib.optionals cfg.rustEnv.enable rustPackages
      ++ lib.optionals cfg.jsEnv.enable nodePackages
    ;
  };
}
