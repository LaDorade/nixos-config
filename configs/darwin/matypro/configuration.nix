{ config, pkgs, mainUser, ... }: {
  imports = [ ../common.nix ];

  # Mandatory for homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [ ];
    casks = [ "bruno" "arduino-ide" "blender"];
  };
}
