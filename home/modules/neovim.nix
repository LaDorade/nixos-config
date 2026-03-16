{
  pkgs,
  lib,
  config,
  home,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim";
  };

  config = {
    home.packages = lib.mkIf (!config.nixvim.enable) [ pkgs.neovim ];
    programs.nixvim = lib.mkIf config.nixvim.enable {
      enable = true;
      globals.mapleader = " ";
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2; # tabwith is 2
      };
      colorschemes.everforest.enable = true;

      plugins = {
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
