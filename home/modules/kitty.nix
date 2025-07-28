{ pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    settings = {
      shell = if lib.hasAttr "fish" pkgs then
        "${pkgs.fish}/bin/fish"
      else
        "${pkgs.zsh}/bin/zsh";
    };
    keybindings = { "ctrl+shift+(" = "previous_window"; };
    themeFile = "Japanesque";
  };
}
