{ config, pkgs, ... }:

{
  # Nom de l'utilisateur et chemin vers son home
  home.username = "maty";
  home.homeDirectory = "/home/maty";

  # Activer Home Manager
  programs.home-manager.enable = true;

  # Paquets à installer pour cet utilisateur
  home.packages = with pkgs; [
    neovim
    git
    htop
    curl
    unzip
    file
  ];

  # Configuration Git (exemple basique)
  programs.git = {
    enable = true;
    userName = "matysse";
    userEmail = "mathisjung02@gmail.com";
  };

  # Bash configuration
  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -la";
    gs = "git status";
  };

  # Exemple de configuration de Neovim (peut être enrichie)
  programs.neovim.enable = true;

  # Définir des variables d'environnement
  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$HOME/.local/bin:$PATH";
  };

  # Pour générer les fichiers de configuration dans ~/.config
  xdg.enable = true;

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}

