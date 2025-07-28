{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [ ./hardware-configuration.nix ];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = ["noatime"];
    };
  };
  # zramSwap.enable = true;
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4*1024;
  } ];
  networking.hostName = "nix-pi";
  environment.systemPackages = with pkgs; [
    vim
    git
    fastfetch
  ];
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };
  services.fail2ban.enable = true;
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # other Nginx options
    virtualHosts."home.canard.cc" =  {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/home";
      #locations."/" = {
        #proxyPass = "http://127.0.0.1:12345";
        #proxyWebsockets = true; # needed if you need to use WebSocket
        #extraConfig =
          # required when the target is also TLS server with multiple hosts
          #"proxy_ssl_server_name on;" +
          # required when the server wants to use HTTP Authentication
          #"proxy_pass_header Authorization;"
          #;
      #};
    };
  };
  security.acme.acceptTerms = true;
  security.acme.certs = {
    "home.canard.cc".email = "youremail@address.com";
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8080 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };



  users.users.pi = {
    isNormalUser = true;
    password = "pi";
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "25.05";
}
