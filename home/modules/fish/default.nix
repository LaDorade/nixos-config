{ pkgs, ... }: {
  home.packages = with pkgs; [
    bat
    fd
  ];
  # TODO: Manage fish system-wide to avoid split config, more easely set
  # packages dependencies, and have fish as pseudo default shell (+ nix-shell)
  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {name = "fzf-fish"; src = fzf-fish.src;} # needs fzf, bat, fd
      {name = "plugin-git"; src = plugin-git.src;}
    ];
    shellAbbrs = {
      f= "$EDITOR \"$(fzf)\"";
      "nix-shell" = "nix-shell --run $SHELL";
      "nixshell" = "nix shell -c $SHELL";
      j= "just";
    };
    shellAliases = {
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

