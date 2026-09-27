{pkgs, lib, config, ...}:
let
  xor = lib.trivial.xor;
  cfg = config.de;
in{
  options = {
    de = {
      enable = lib.mkEnableOption "Enable a desktop environment";
      xfce.enable = lib.mkEnableOption "Use XFCE as DE";
      plasma.enable = lib.mkEnableOption "Use KDE Plasma as DE";
      gnome.enable = lib.mkEnableOption "Use Gnome as DE";
    };
  };
  config = lib.mkIf cfg.enable {
    # DE's
    services.xserver.enable = true;

    # XFCE
    services.xserver.displayManager.lightdm.enable = cfg.xfce.enable;
    services.xserver.desktopManager.xfce.enable = cfg.xfce.enable;

    # KDE Plasma
    services.displayManager.sddm.enable = cfg.plasma.enable;
    services.desktopManager.plasma6.enable = cfg.plasma.enable;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = cfg.gnome.enable;
    services.desktopManager.gnome.enable = cfg.gnome.enable;

    # Audio
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
