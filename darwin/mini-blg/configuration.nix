{ config, pkgs, ... }: {
  # System settings
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

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
  environment.systemPackages = with pkgs; [ nixfmt nixd vim git curl wget ];

  # User settings
  users.users.matysse_blg = {
    name = "matysse_blg";
    home = "/Users/matysse_blg";
  };

  # Fonts
  # fonts.fontDir.enable = true;
  # fonts.fonts = with pkgs; [
  #   (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  # ];
}
