{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "ls -alh";
      gs = "git status";
    };

    shellInit = ''
      set -gx EDITOR nvim
      set -gx PATH $HOME/.local/bin $PATH
    '';
  };
}

