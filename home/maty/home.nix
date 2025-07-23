{ config, lib, pkgs, ... }:

let 
  mangohud = import ../../modules/mangohud.nix { inherit config lib pkgs; };
in
{
  imports = [
    ../../modules/dev.nix
  ];
  devEnvs.enable = true;
  devEnvs.rustEnv.enable = true;

  home.username = "maty";
  home.homeDirectory = "/home/maty";

  programs.home-manager.enable = true;

  programs.mangohud = {
    enable = true;
    settings = {
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      vram = true;
      ram = true;
      swap = true;
      fps = true;
      frametime = true;
      frame_timing = true;
      resolution = true;
    };
    settingsPerApplication = {
      pinta = {
        no_display = true;
      };
    };
  };

  home.packages = with pkgs; [
    neovim
    discord-ptb
    pinta
    protonup
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

