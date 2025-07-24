{pkgs, ...}:{
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;

    extraPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
