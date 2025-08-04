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
    };
  };
  config = lib.mkIf cfg.enable {
    assertions = [{
      assertion = xor cfg.plasma.enable cfg.xfce.enable;
      message = "You can enable only one DE !"; 
    }];
    # DE's
    services.xserver.enable = true;

    # XFCE
    services.xserver.displayManager.lightdm.enable = cfg.xfce.enable;
    services.xserver.desktopManager.xfce.enable = cfg.xfce.enable;

    # KDE Plasma
    services.xserver.displayManager.sddm.enable = cfg.plasma.enable;
    services.xserver.desktopManager.plasma6.enable = cfg.plasma.enable;


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
