{ config, pkgs, mainUser, ... }: { 
  imports = [
    ../common.nix
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [ ];
    casks = [ "bruno" ];
  };
}
