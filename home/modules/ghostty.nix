{ pkgs, lib, ... }: {
  programs.ghostty = {
    enable = true;
	package = pkgs.ghostty-bin;
  };
}
