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
      f = "$EDITOR \"$(fzf)\"";

      # zig
      zb = "zig build";

	  # git
      gs    = "git status";

      # js
      p  = "pnpm"    ;
      pi = "pnpm i"  ;
      pd = "pnpm dev";
      y  = "yarn"    ;
      yd = "yarn dev";

	  # misc
      j = "just";
      c  = "clear";
      h  = "history";
      la = "ls -alh";
      ll = "ls -lh";
    };

    shellAliases = {
      cd = "z";
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

