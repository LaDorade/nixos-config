{ config, lib, pkgs, ... }:
let
in {
  imports = [ ];

  home.username = "pi";
  home.homeDirectory = "/home/pi";
  home.packages = with pkgs; [
    ripgrep
    fastfetch
    htop
    curl
    unzip
    file
  ];

  programs.git = {
    enable = true;
    userName = "matysse";
    userEmail = "mathisjung02@gmail.com";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -la";
    gs = "git status";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$HOME/.local/bin:$PATH";
  };

  # Pour générer les fichiers de configuration dans ~/.config
  xdg.enable = true;

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
