{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;
in {
  options.devEnvs = {
    enable = mkEnableOption "Global dev env";
    rustEnv.enable = mkEnableOption "Rust dev environment";
    jsEnv.enable = mkEnableOption "Js node dev environment";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      mkIf cfg.rustEnv.enable [
        rustup # provides rustc, cargo, rust-analyzer and more
      ];
    home.packages = with pkgs;
      home.packages
      ++ mkIf cfg.jsEnv.enable [
        nodejs_24 # provides node, npm, npx
        yarn
      ];
  };
}
