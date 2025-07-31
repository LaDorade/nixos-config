{ config, lib, pkgs, mainUser, ... }:
let username = mainUser;
in {
  imports = [
    ../modules/dev.nix
    ../modules/fish
    ../modules/alacritty.nix
    ../modules/kitty.nix
    ../modules/nixvim.nix
  ];
  devEnvs.enable = true;
  devEnvs.rustEnv.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";

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
    settingsPerApplication = { pinta = { no_display = true; }; };
  };

  home.packages = with pkgs; [
    discord-ptb
    obsidian
    pinta
    protonup
    ripgrep
    fastfetch
    htop
    curl
    unzip
    file
  ];

  # Version de la config, doit rester constante après première install
  home.stateVersion = "25.05";
}
