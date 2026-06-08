{
pkgs,
lib,
config,
...
}:
let
	# TODO: move this into devEnv
	lsps = with pkgs; [
			vscode-langservers-extracted

			lua-language-server

			svelte-language-server
			tailwindcss-language-server

			typescript-go
			vtsls # ts lsp

			nixd # nix lsp
			gopls # go lsp
	];

	otherPackages = with pkgs; [
		lazygit
		tree-sitter
	];
in 
{
	options = {
		neovim = {
			enable = lib.mkEnableOption "Use Neovim";
			useLsps = lib.mkEnableOption "Activate neovim lsps";
		};
	};

	config = {
		home.packages = []
			++ lib.optionals config.neovim.enable otherPackages
			++ lib.optionals config.neovim.useLsps lsps;

		programs.neovim = lib.mkIf config.neovim.enable {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
			viAlias = true;
		};
	};
}
