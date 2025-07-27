{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2; # tabwith is 2
    };
    plugins = {
      nix.enable = true;
      comment.enable = true;
      oil = { enable = true; };
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [ "lua" "python" "rust" "nix" "bash" "json" ];
          highlight = {
            enable = true;
            # additionalVimRegexHighlighting = false; # true si tu veux combiner avec l'ancienne coloration
          };
        };

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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
        ];
      };
    };
    colorschemes.modus.enable = true;
    plugins.lualine.enable = true;

    extraPackages = with pkgs; [ wl-clipboard ];
  };
}
