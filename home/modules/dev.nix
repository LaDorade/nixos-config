{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;

  commonPackages = with pkgs; [ ];
  rustPackages = with pkgs; [ rustup ];
  phpPackages = with pkgs; [ php php84Packages.composer ];
  nodePackages = with pkgs; [ nodejs_24 yarn ]; # Node contains npm, npx
in {
  options.devEnvs = {
    enable = mkEnableOption "Global dev env";
    rustEnv.enable = mkEnableOption "Rust dev environment";
    phpEnv.enable = mkEnableOption "PHP dev environment";
    nodeEnv.enable = mkEnableOption "Js node dev environment";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      commonPackages ++ lib.optionals cfg.rustEnv.enable rustPackages
      ++ lib.optionals cfg.nodeEnv.enable nodePackages
      ++ lib.optionals cfg.phpEnv.enable phpPackages
    ;
  };
}
