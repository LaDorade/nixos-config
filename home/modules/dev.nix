{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;

  commonPackages = with pkgs; [ ];
  rustPackages = with pkgs; [ rustc cargo rust-analyzer rustfmt ];
  phpPackages = with pkgs; [ php php84Packages.composer ];
  nodePackages = with pkgs; [
    nodejs_24 # Node contains npm, npx
    (yarn.override { withNode = false; }) # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ya/yarn/package.nix
  ];
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
