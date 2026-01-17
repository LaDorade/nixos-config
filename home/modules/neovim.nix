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
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2; # tabwith is 2
      };
      plugins = {
        nix.enable = true;
        zig.enable = true;

        comment.enable = true;

        oil = {
          enable = true;
        };
        mini.enable = false;
        telescope.enable = true;
        web-devicons.enable = true;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings.sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            zls = {
              enable = true;
            };
          };
        };
        treesitter = {
          enable = true;
          settings = {
            ensure_installed = [
              "lua"
              "python"
              "rust"
              "nix"
              "json"
              "go"
            ];
            highlight = {
              enable = true;
              # additionalVimRegexHighlighting = false;
            };
          };

          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            c
            bash
            json
            lua
            make
            markdown
            nix
            regex
            toml
            vim
            vimdoc
            xml
            yaml
            zig
          ];
        };
        lualine.enable = true;
      };
      colorschemes.everforest.enable = true;

      extraPackages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ wl-clipboard ]);
    };
  };
}
