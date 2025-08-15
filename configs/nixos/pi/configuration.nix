{ config, pkgs, lib, mainUser, hostName, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../common.nix
    ./nginx.nix
  ];
  networking.hostName = hostName;
  networking.wireless.enable = false;
  networking.networkmanager.enable = lib.mkForce false;
  services.openssh = {
    enable = true;
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 67 80 443 8080 ];
    allowedUDPPorts = [ 67 ];  # DHCP
  };

  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.05";
}
