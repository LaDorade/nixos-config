{ config, pkgs, lib, mainUser, ... }:
{
  environment.systemPackages = with pkgs; [ 
    just
    git
    vim
    curl
    wget
  ];
}
