{ config, pkgs, lib, ... }: {
  imports = [
    ../common.nix
    ../modules/fish
    # ../modules/kitty.nix
  ];

  # ? Workaround to see home-manager apps in spotlight
  # * Now replaced by mac-app-util
  # https://github.com/hraban/mac-app-util
  
  # home.activation.makeTrampolineApps = lib.hm.dag.entryAfter [ "writeBoundary" ] (
  #   # builtins.readFile ./make-app-trampolines.sh
  #   ''''
  # );
}