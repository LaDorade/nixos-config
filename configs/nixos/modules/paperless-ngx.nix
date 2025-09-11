{config, lib, ...}:
let
  cfg = config.paperless;
in {
  options.paperless = {
    enable = lib.mkEnableOption "Init paperless";
    url = lib.mkOption {
      type = with lib.types; uniq str;
      description = "worldwide url";
      example = "https://snoup.fr";
      default = "https://papers.home.canard.cc";
    };
  };
  config = lib.mkIf cfg.enable {
    services.paperless = {
      enable = true;
      # consumptionDirIsPublic = true;
      settings = {
        # PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        #   ".DS_STORE/*"
        #   "desktop.ini"
        # ];
        # PAPERLESS_OCR_LANGUAGE = "fra+eng";
        # PAPERLESS_OCR_USER_ARGS = {
	  # continue_on_soft_render_error = true;
	  #      };
        PAPERLESS_URL = cfg.url;
        # PAPERLESS_ALLOWED_HOSTS = "localhost,192.168.1.110,home.canard.cc";
        # PAPERLESS_CORS_ALLOWED_HOSTS = "localhost,192.168.1.110,home.canard.cc";
	# USE_X_FORWARD_HOST = true;
	# USE_X_FORWARD_PORT = true;
	# PAPERLESS_PROXY_SSL_HEADER = [ "HTTP_X_FORWARDED_PROTO" "https"];
	# PAPERLESS_CORS_ALLOWED_ORIGINS = "https://home.canard.cc";
	#        PAPERLESS_CORS_ALLOW_CREDENTIALS = "true";
      };
    };
  };
}
