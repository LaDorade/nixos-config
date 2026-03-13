{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.devEnvs;
in
{
  options = {
    nixenv.enable = mkEnableOption "Enable nix dev env";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt # format
      nil # lsp
      direnv
    ];
  };
}
