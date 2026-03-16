{ config, lib, pkgs, hostName, ... }:

{
  imports = [
    ../common.nix
    ../modules/gui/DEs.nix
    ../modules/docker.nix
  ];

  networking.hostName = hostName; 
  networking.networkmanager.enable = lib.mkForce false;

  # workaround to make vscode work
  # https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
  programs.nix-ld.enable = true;

  de = {
    enable = true;
    xfce.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim 
    neovim
    ripgrep
    fastfetch

    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
    libGL
  ];


  users.users.wsl-maty.isNormalUser = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
