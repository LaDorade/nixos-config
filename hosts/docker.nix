{
  config,
  pkgs,
  lib,
  username,
  ...
}: let
in {
  options = {
    enableDocker = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Docker and configure the daemon.";
    };
    mySystem.mainUser = lib.mkOption {
      type = lib.types.str;
      example = "alice";
      description = "Nom d'utilisateur principal du système (pour le groupe docker, etc).";
    };
  };

  config = lib.mkIf config.enableDocker {
    assertions = [
      {
        assertion = config.mySystem.mainUser != "";
        message = "mainUser doit être défini pour ajouter le groupe docker";
      }
    ];

    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [docker-compose];

    users.users.${username}.extraGroups = ["docker"];

    systemd.services.docker.wantedBy = lib.mkForce ["multi-user.target"];
  };
}
