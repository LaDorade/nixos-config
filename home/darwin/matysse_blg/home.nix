{
  pkgs,
  # config,
  # lib,
  # osConfig,
  # home,
  ...
}:
{
  imports = [
    ../common.nix
	../../modules/tmux.nix
    ../../modules/neovim.nix
    ../../modules/fish
    ../../modules/vscode.nix
    ../../modules/dev.nix
    ../../modules/nix.nix
  ];

  nixenv.enable = true;

  tmux.enable = true;
  neovim = {
	  enable  = true;
	  useLsps = true;
  };

  home.packages = with pkgs; [
  	redis
  ];

  devEnvs = {
    enable 		   = true;
    phpEnv.enable  = true;
    nodeEnv.enable = true;
    rustEnv.enable = true;
    zigEnv.enable  = true;
	goEnv.enable   = true;
  };

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
