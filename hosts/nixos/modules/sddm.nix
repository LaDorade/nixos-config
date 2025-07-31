{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    where-is-my-sddm-theme
  ];
}
