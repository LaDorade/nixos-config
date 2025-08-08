# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  fflorent = import ../modules/fflorent { inherit pkgs lib ; };
in{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../modules/gui/DEs.nix
  ];

  de = {
    enable = true;
    xfce.enable = true;
  };

  services.homer = {
    enable = true;
    settings = {
      title = "App dashboard";
    };
    virtualHost.nginx.enable = true;
    virtualHost.domain = "home.canard.cc";
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8080 ];
  };

  environment.systemPackages = [
    pkgs.minimal-grub-theme
  ];
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth = {
      enable = true;
      theme = "fflorent";
      themePackages = [ pkgs.plymouth-blahaj-theme fflorent ];
    };
 
  boot.loader = {
    timeout = 20;
    efi.efiSysMountPoint = "/boot";

   grub = {
      enable = true;
      theme = "${pkgs.minimal-grub-theme}";
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = ["nodev"];
      useOSProber = true;
      # extraEntriesBeforeNixOs = false;
    };
  };

  networking.hostName = "lenovo-laptop";

  services.printing.enable = true;
  users.users.lenovo = {
    isNormalUser = true;
    description = "lenovo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  services.openssh.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
