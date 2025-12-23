{
  config,
  pkgs,
  mainUser,
  ...
}:
{
  imports = [
    ../base.nix
    ./fish.nix
  ];

  system.primaryUser = mainUser;
  # User settings
  users.users.${mainUser} = {
    name = "${mainUser}";
    home = "/Users/${mainUser}";
    shell = pkgs.fish;
  };
  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    nixfmt
    nixd
  ];

  # Nix configuration
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
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
  system.activationScripts.applications.text = pkgs.lib.mkForce (''
    echo "setting up ~/Applications/Nix..."
    rm -rf ~/Applications/Nix
    mkdir -p ~/Applications/Nix
    chown ${mainUser} ~/Applications/Nix
    find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read -r f; do
      src="$(/usr/bin/stat -f%Y "$f")"
      appname="$(basename "$src")"
      osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Users/${mainUser}/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
    done
  '');

  # environment.pathsToLink = [ "/Applications/Nix Apps" ];
  # # Pour créer automatiquement le dossier et gérer les liens d’applications :
  # environment.variables.NIX_APP_LINK_DIR = "/Applications/Nix Apps";

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  # System settings
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  security.pam.services.sudo_local.touchIdAuth = true;
}
