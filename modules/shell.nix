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

    functions = {
      fish_prompt = builtins.readFile ./fish/fish_prompt.fish;
      fish_greeting = builtins.readFile ./fish/fish_greeting.fish;
    };
  };
}

