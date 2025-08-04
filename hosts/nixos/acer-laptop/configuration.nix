# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  hostName,
  ...
}: let
  fflorent = import ../modules/fflorent { inherit pkgs lib ; };
in{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../modules/docker.nix
    ../modules/gui/DEs.nix
  ];

  de = {
    enable = true;
    xfce.enable = true;
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

  networking.hostName = hostName;

  programs.firefox.enable = true;

  services.printing.enable = true;
  security.rtkit.enable = true;
  users.users.acer = {
    isNormalUser = true;
    description = "acer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  services.openssh.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
