{ pkgs, ... }: {
  # Zoxide & fzf can be system-wide or user-specific programs.
  # Ripgrep is a program only for home-manager but packaged in nixpkgs.
  commonPackages = with pkgs; [
    ripgrep
    zoxide
    fzf
  ];
}