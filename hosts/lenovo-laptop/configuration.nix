# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  monTheme = import ../my-plymouth-theme { inherit pkgs lib ; };
in{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../docker.nix
  ];
  enableDocker = true;

  environment.systemPackages = [
    pkgs.minimal-grub-theme
  ];
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth = {
      enable = true;
      theme = "mon-theme";
      themePackages = [ pkgs.plymouth-blahaj-theme monTheme ];
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

  # GUI
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users.lenovo = {
    isNormalUser = true;
    description = "lenovo";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  services.openssh.enable = true;
  system.stateVersion = "25.05"; # Did you read the comment?
}
