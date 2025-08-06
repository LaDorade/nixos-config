{config, lib, ...}:
let
  cfg = config.paperless;
in {
  options.paperless = {
    enable = lib.mkEnableOption "Init paperless";
    url = lib.mkOption {
      type = with lib.types; uniq str;
      description = "worldwide url";
      example = "https://papers.snoup.fr";
      default = "https://papers.canard.cc";
    };
  };
  config = lib.mkIf cfg.enable {
    services.paperless = {
      enable = true;
      consumptionDirIsPublic = true;
      settings = {
        PAPERLESS_CONSUMER_IGNORE_PATTERN = [
          ".DS_STORE/*"
          "desktop.ini"
        ];
        PAPERLESS_OCR_LANGUAGE = "fra+eng";
        PAPERLESS_OCR_USER_ARGS = {
          optimize = 1;
          pdfa_image_compression = "lossless";
        };
        PAPERLESS_URL = cfg.url;
      };
    };
  };
}
