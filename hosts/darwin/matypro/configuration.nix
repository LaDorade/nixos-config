{ config, pkgs, mainUser, ... }: {
  imports = [ ../common.nix ];

  # Mandatory for homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [ 
      "cowsay" 
    ];
    casks = [
      "bruno"
    ];
  };
}
