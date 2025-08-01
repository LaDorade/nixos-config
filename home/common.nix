{ config, lib, pkgs, mainUser, ... }: {
  imports = [
    ./modules/neovim.nix
  ];

  # ? Move this to the common of configs
  # but this can only be done in systemPackages
  # because nix darwin does not have programs.nh
  programs.nh = {
    enable = true;
    flake = null;
    clean.enable = true;
  };

  home.packages = with pkgs; [ ripgrep fzf fastfetch htop ];

  programs.zoxide = { enable = true; };

  programs.git = {
    enable = true;
    userName = "matysse";
    userEmail = "mathisjung02@gmail.com";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -la";
    gs = "git status";
    c = "clear";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$HOME/.local/bin:$PATH";
  };

  # Pour générer les fichiers de configuration dans ~/.config
  xdg.enable = true;

  programs.home-manager.enable = true;
}
