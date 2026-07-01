{ config, lib, pkgs, mainUser, ... }:
let username = mainUser;
in {
	imports = [
		../common.nix
			../modules/neovim.nix
			../modules/dev.nix
			../modules/fish
	];
	neovim = {
		enable = true;
		useLsps = true;
	};
	devEnvs.enable = true;
	devEnvs.nodeEnv.enable = true;
	devEnvs.rustEnv.enable = true;
	devEnvs.zigEnv.enable  = true;
	devEnvs.phpEnv.enable  = true;

  home.username = username;
  #home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # CLI
    unzip
    file

	# C
	clang-tools
	libgcc
	gnumake

	# misc
	emacs
  ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
