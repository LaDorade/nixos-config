{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;

  commonPackages = with pkgs; [ cloc nil ];

  rustPackages = with pkgs; [ rustup ];
  zigPackages  = with pkgs; [ zig ];
  odinPackages = with pkgs; [ odin ols ];
  goPackages   = with pkgs; [ go wgo gopls ];
  phpPackages  = with pkgs; [ php php84Packages.composer ];
  nodePackages = with pkgs; [
    nodejs_26 # Node contains npm, npx
    (yarn.override { withNode = false; }) # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ya/yarn/package.nix
    (pnpm.override { withNode = false; })
    bun
  ];
  haskellPkgs = with pkgs; [
    ghc
    haskell-language-server
    haskellPackages.hlint
  ];
in
{
  options.devEnvs = {
    enable = mkEnableOption "Global dev env";
    rustEnv.enable = mkEnableOption "Rust dev environment";
    odinEnv.enable = mkEnableOption "Odin dev environment";
    goEnv.enable = mkEnableOption "Go dev environment";
    phpEnv.enable = mkEnableOption "PHP dev environment";
    nodeEnv.enable = mkEnableOption "Js node dev environment";
    zigEnv.enable = mkEnableOption "Zig dev environment";
    haskellEnv.enable = mkEnableOption "Haskell dev environment";
  };

  config = mkIf cfg.enable {
    home.packages =
      commonPackages
      ++ lib.optionals cfg.rustEnv.enable rustPackages
      ++ lib.optionals cfg.nodeEnv.enable nodePackages
      ++ lib.optionals cfg.phpEnv.enable phpPackages
      ++ lib.optionals cfg.goEnv.enable goPackages
      ++ lib.optionals cfg.zigEnv.enable zigPackages
      ++ lib.optionals cfg.odinEnv.enable odinPackages
      ++ lib.optionals cfg.haskellEnv.enable haskellPkgs
    ;
  };
}
