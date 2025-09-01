{ config, lib, pkgs, ... }:

let
  cfg = config.services.firefox;
in
{
  options.services.firefox = {
    enable = lib.mkEnableOption "firefox declared";
  };

  config = lib.mkIf cfg.enable {
  programs.firefox = {
    enable = true;
    profiles.zik = {

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Yandex" = {
          urls = [{
            template = "https://yandex.com/search/?text={searchTerms}";
          }];
          icon = "https://yastatic.net/s3/home-static/_/i/logo-ya.svg";
          definedAliases = [ "ya" ];
        };
        "wiki" = {
          urls = [{
            template = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}&go=Go";
          }];
          icon = "https://upload.wikimedia.org/wikipedia/commons/6/63/Wikipedia-logo.png";
          definedAliases = [ "wiki" ];
        };
      };
      search.force = true;

      bookmarks = [
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
      ];

      settings = {
      };

      userChrome = ''                         
        /* some css */                        
      '';                                      

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        stylus
        ublock-origin
        darkreader
        youtube-remix
        twp-translate
        steamdb
        tampermonkey
      ];

    };
  };
  };
}