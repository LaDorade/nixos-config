{ config, pkgs, lib, inputs, mainUser, system, hostName, ... }:
let
  username = mainUser;
  fflorent = import ../modules/fflorent { inherit pkgs lib ; };
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
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.displayManager.sddm = {
    theme = "${pkgs.where-is-my-sddm-theme}/share/sddm/themes/where_is_my_sddm_theme";
  };
  hardware.bluetooth.enable = true;

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = [ pkgs.exfat ];
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

  networking.hostName = hostName; # Define your hostname.
  services.printing.enable = true;
  # Don't know if I need fish systemwide to have all completions
  # based on the documentation: yes it needs it (https://nixos.wiki/wiki/Fish)
  programs.fish.enable = true;
  users.groups.gamer = { };
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "dialout" "gamer" ];
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
    gparted
    lact # manage amd GPU
    solaar # manager logitech devices
    exfat
  ];
  hardware.logitech.wireless.enable = true; # neeeded by solar
  hardware.logitech.wireless.enableGraphical = true;
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
