{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      # exemple de configuration
      terminal = {
        shell = {
          program = "${pkgs.fish}/bin/fish";
          args = [ "--init-command" "echo; fastfetch; echo" ];
        };
      };
      font = { size = 12.0; };
      colors.primary = {
        background = "0x1e1e2e";
        foreground = "0xcdd6f4";
      };
    };
  };
}

