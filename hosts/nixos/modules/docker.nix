{ config, pkgs, lib, mainUser, ... }:
let username = mainUser;
in {
  options = {
    enableDocker = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Docker and configure the daemon.";
    };
  };

  config = lib.mkIf config.enableDocker {
    assertions = [{
      assertion = username != "";
      message = "mainUser doit être défini pour ajouter le groupe docker";
    }];

    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [ docker-compose ];

    users.users.${username}.extraGroups = [ "docker" ];

    systemd.services.docker.wantedBy = lib.mkForce [ "multi-user.target" ];
  };
}
