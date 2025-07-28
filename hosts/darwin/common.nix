{ config, pkgs, mainUser, ... }: {
  imports = [ ../base.nix ];

  system.primaryUser = mainUser;
  # User settings
  users.users.${mainUser} = {
    name = "${mainUser}";
    home = "/Users/${mainUser}";
  };

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

  # System packages
  environment.systemPackages = with pkgs; [ nixfmt nixd ];
  # environment.pathsToLink = [ "/Applications/Nix Apps" ];
  # # Pour créer automatiquement le dossier et gérer les liens d’applications :
  # environment.variables.NIX_APP_LINK_DIR = "/Applications/Nix Apps";

  # Fonts
  # fonts.fontDir.enable = true;
  # fonts.fonts = with pkgs; [
  #   (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  # ];

  # System settings
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.services.sudo_local.touchIdAuth = true;
}
