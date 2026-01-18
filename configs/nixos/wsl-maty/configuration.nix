{ config, lib, pkgs, hostName, ... }:

{
  imports = [
    ../common.nix
  ];

  networking.hostName = hostName; 

  # workaround to make vscode work
  # https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim 
    neovim
    ripgrep
    fastfetch
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
