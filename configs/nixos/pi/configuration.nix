{ config, pkgs, lib, mainUser, hostName, ... }: {
  imports = [ ./hardware-configuration.nix ../common.nix ];
  networking.hostName = hostName;
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };
  services.fail2ban.enable = true;
  services.homer = {
    enable = true;
    settings = {
      title = "bijour";
      services = [
        {
	  name = "My beloved one's";
	  icon = "fas fa-heartbeat";
	  items = [
	    {
	      name = "Paperless";
	      type = "PaperlessNG";
	      icon = "fas fa-code-branch";
	      apikey = "6ad4ce9bb0ab3634e204c59d18f965d8e3449421";
	      tag = "app";
	      keywords = "self hosted papers";
	      url = "https://papers.canard.cc/";
	      target = "_blank";
	    }
          ];
	}
      ];
    };
    virtualHost = {
      domain = "home.canard.cc";
      nginx.enable = true;
    };
  };
  services.nginx = {
    # enable = true; # Homer enables it
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."home.canard.cc" = {
      enableACME = true;
      forceSSL = true;
    };
   virtualHosts."papers.canard.cc" = let 
     address = "http://192.168.1.110:28981";
   in{
     enableACME = true;
     forceSSL = true;
     locations."/" = {
       proxyPass = address;
       proxyWebsockets = true;
       extraConfig = ''
          # CORS Headers
          add_header 'Access-Control-Allow-Origin' 'https://home.canard.cc' always;
          add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS, PUT, DELETE' always;
          add_header 'Access-Control-Allow-Headers' 'Origin, Content-Type, Accept, Authorization' always;
          add_header 'Access-Control-Allow-Credentials' 'true' always;

          # Préflight OPTIONS
          if ($request_method = 'OPTIONS') {
              # add_header 'Access-Control-Max-Age' 86400;
              # add_header 'Content-Length' 0;
              # add_header 'Content-Type' 'text/plain charset=UTF-8';
              return 204;
          }
        '';
     };
   };
  };
  security.acme.acceptTerms = true;
  security.acme.certs = { 
    "home.canard.cc".email = "mathisjung02@gmail.com";
    "papers.canard.cc".email = "mathisjung02@gmail.com";
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8080 ];
  };

  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.05";
}
