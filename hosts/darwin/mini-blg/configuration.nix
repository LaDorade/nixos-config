{ config, pkgs, mainUser, ... }: { 
  imports = [
    ../common.nix
  ];

  homebrew = {
    enable = true;
    casks = [ "bruno" ];
    brews = [ ];

    # Clean uninstalls casks and brews but send an error message
    onActivation.cleanup = "zap";
  };
}
