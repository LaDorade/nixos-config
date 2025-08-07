{ config, pkgs, inputs, mainUser, system, hostName, ... }:
let username = mainUser;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix
    ../modules/sddm.nix
    ../modules/gui/DEs.nix
  ];
  de = {
    enable = true;
    plasma.enable = true;
  };
  services.displayManager.sddm = {
    theme = "${pkgs.where-is-my-sddm-theme}/share/sddm/themes/where_is_my_sddm_theme";
  };

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

  networking.hostName = hostName; # Define your hostname.
  services.printing.enable = true;
  # Don't know if I need fish systemwide to have all completions
  # based on the documentation: yes it needs it (https://nixos.wiki/wiki/Fish)
  programs.fish.enable = true;
  users.groups.gamer = { };
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "gamer" ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  # Manager AMD gpu
  environment.systemPackages = with pkgs; [ 
    inputs.zen-browser.packages."${system}".twilight
    lact
  ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
