{pkgs, config, lib, ...}: {
  # Mandotory to detect fish in startup terms
  # Kitty do not see user $Path on startup
  # This is a workaround to ensure fish is available by setting it system-wide
  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
}