{ config, pkgs, lib, inputs, mainUser, system, hostName, ... }:
{

  # keyboard related
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess"
  '';

  boot.kernelParams = [ "usbcore.autosuspend=-1" ];
  services.tlp.settings = {
    USB_AUTOSUSPEND = 0;
  };
}
