{ config, pkgs, ... }: {
  # System settings
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";


  # environment.pathsToLink = [ "/Applications/Nix Apps" ];
  # # Pour créer automatiquement le dossier et gérer les liens d’applications :
  # environment.variables.NIX_APP_LINK_DIR = "/Applications/Nix Apps";

  # Nix configuration
  nix = {
    settings = { experimental-features = [ "nix-command" "flakes" ]; };
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  # Mandatory for homebrew
  system.primaryUser = "sakura";
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [ "cowsay" ];
    casks = [
      "bruno"
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  # User settings
  users.users.sakura = {
    name = "sakura";
    home = "/Users/sakura";
  };

  # Fonts
  # fonts.fontDir.enable = true;
  # fonts.fonts = with pkgs; [
  #   (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  # ];
  security.pam.services.sudo_local.touchIdAuth = true;
}
