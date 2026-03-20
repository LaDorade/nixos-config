{
pkgs,
lib,
config,
...
}:
let
	lsps = with pkgs; [
			vscode-langservers-extracted

			lua-language-server

			svelte-language-server
			tailwindcss-language-server

			typescript-go
			vtsls # ts lsp

			nixd # nix lsp
	];

	otherPackages = with pkgs; [
		lazygit
	];
in 
{
	options = {
		neovim = {
			enable = lib.mkEnableOption "Use Neovim";
			useLsps = lib.mkEnableOption "Activate neovim lsps";
		};
		nixvim.enable = lib.mkEnableOption "Enable nixvim";
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

		programs.nixvim = lib.mkIf config.nixvim.enable {
			enable = true;
			globals.mapleader = " ";
			diagonostic = {
				virtual_lines = true;
				virtual_text = false;
			};
			opts = {
				number = true;
				relativenumber = true;
				tabstop = 4;    # indent to 4 space
				shiftwidth = 0; # same as tabstop
			};
			colorschemes.monokai-pro.enable = true;

			lsp = {
				keymaps = [
					{
						key = "<leader>es";
						action = "<CMD>LspEslintFixAll<Enter>";
					}
					{
						key = "gd";
						lspBufAction = "definition";
					}
					{
						key = "gD";
						lspBufAction = "references";
					}
					{
						key = "gt";
						lspBufAction = "type_definition";
					}
					{
						key = "gi";
						lspBufAction = "implementation";
					}
					{
						key = "K";
						lspBufAction = "hover";
					}
				];
				servers = {
					vtsls.enable  = true;
					nixd.enable   = true;
					eslint.enable = true;
					svelte.enable = true;
					tailwindcss.enable = true;
				};
			};
			plugins = {
				lsp.enable = true;
				tiny-inline-diagnostic.enable = true;
				lint.enable = true;
				treesitter = {
					enable = true;
					highlight.enable = true;
					indent.enable = true;
				};
				web-devicons.enable = true;
				lazygit = {
					enable = true;
				};
				telescope = {
					enable = true;
					keymaps = {
						"<leader>pf" = {
							action = "find_files";
							options = {
								desc = "Telescope find files";
							};
						};
						"<leader>pb" = {
							action = "buffers";
							options = {
								desc = "Telescope open buffers";
							};
						};
						"<leader>pg" = {
							action = "live_grep";
						};
					};
				};
			};
			keymaps = [
				{
					mode = "n";
					key = "<leader>pv";
					action.__raw = "vim.cmd.Ex"; # go to file tree
				}
				{
					mode = "n";
					key = "<leader>lg";
					action = "<cmd>LazyGit<cr>"; # open lazygit
				}
			];

			extraPackages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ wl-clipboard ]);
		};
	};
}
