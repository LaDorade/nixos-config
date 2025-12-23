{
  config,
  pkgs,
  mainUser,
  ...
}:
{
  imports = [ ../common.nix ];

  environment.systemPackages = with pkgs; [
    c3c # here because of fish completions
  ];
  # Mandatory for homebrew
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [ ];
    casks = [
      "bruno"
      "arduino-ide"
      "blender"
    ];
  };
}
