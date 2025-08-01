{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      j= "just";
      cd = "z";
      c = "clear";
      h = "history";
      ll = "ls -alh";
      gs = "git status";
    };

    shellInit = ''
      set -gx EDITOR nvim
      set -gx PATH $HOME/.local/bin $PATH
    '';
    shellInitLast = ''
      zoxide init fish | source
    '';

    functions = {
      fish_prompt = builtins.readFile ./fish_prompt.fish;
      fish_greeting = builtins.readFile ./fish_greeting.fish;
    };
  };
}

