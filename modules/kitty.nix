{pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
    };
    keybindings = {
      "ctrl+shift+(" = "previous_window";
    };
    themeFile = "Japanesque";
  };
}
