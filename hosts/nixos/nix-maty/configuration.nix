{ config, pkgs, mainUser, ... }:
let username = mainUser;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
  fileSystems."/mnt/steamgames" = {
    device = "/dev/disk/by-uuid/17ee64be-2d28-4040-ad87-f3a22a44ce1e";
    fsType = "ext4";
  };
  systemd.tmpfiles.rules = [
    # Format : type path mode user group age argument
    "d /mnt/steamgames 0770 root gamer - -"
  ];

  hardware.graphics = { enable = true; };
  services.xserver.videoDrivers = [ "amdgpu" ];

  networking.hostName = "nix-maty"; # Define your hostname.

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.groups.gamer = { };
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "gamer" ];
    packages = with pkgs; [ ];
  };
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  # Manager AMD gpu
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
