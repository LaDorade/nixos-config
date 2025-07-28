{ config, lib, pkgs, mainUser, ... }:
{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fastfetch
    htop
  ];

  programs.zoxide = {
    enable = true;
  };

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