{ config, pkgs, lib, mainUser, hostName, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../common.nix
    ./nginx.nix
  ];
  networking.hostName = hostName;
  networking.wireless.enable = true;
  networking.networkmanager.enable = lib.mkForce false;
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8080 ];
  };

  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.05";
}
