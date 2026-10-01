{
  flake-file.inputs.firefox-addons = {
    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.homeModules.firefox =
    {
      inputs,
      pkgs,
      config,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles = {
          zik = {
            id = 0;
            isDefault = true;
            search.engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "wiki" = {
                urls = [
                  {
                    template = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}&go=Go";
                  }
                ];
                icon = "https://upload.wikimedia.org/wikipedia/commons/6/63/Wikipedia-logo.png";
                definedAliases = [ "wiki" ];
              };
            };
            search.force = true;

            bookmarks = [
              {
                name = "nixpkgs search";
                keyword = "np";
                url = "https://search.nixos.org/packages?query=%s";
              }
              {
                name = "home-manager options";
                keyword = "hmo";
                url = "https://home-manager-options.extranix.com/?query=%s";
              }
              {
                name = "github search";
                keyword = "gh";
                url = "https://github.com/search?q=%s";
              }
            ];

            settings = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "toolkit.telemetry.enabled" = false;
              "datareporting.healthreport.uploadEnabled" = false;
              "browser.newtabpage.activity-stream.feeds.telemetry" = false;
              "browser.ping-centre.telemetry" = false;
              "app.shield.optoutstudies.enabled" = false;
              "browser.discovery.enabled" = false;
              "browser.newtabpage.activity-stream.showSponsored" = false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
              "extensions.pocket.enabled" = false;
              "browser.urlbar.suggest.quicksuggest.sponsored" = false;
              "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
              "browser.contentblocking.category" = "strict";
              "privacy.trackingprotection.enabled" = true;
              "network.cookie.cookieBehavior" = 1;
            };

            userChrome = ''
              #firefox-view-button { display: none !important; }
              #PersonalToolbar {
                visibility: collapse;
              }
              #navigator-toolbox:hover #PersonalToolbar {
                visibility: visible;
              }
            '';

            extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
              stylus
              return-youtube-dislikes
              ublock-origin
              darkreader
              youtube-redux
              translate-web-pages
              steam-database
              protondb-for-steam
              control-panel-for-twitter
              keepassxc-browser

            ];
          };
          ru = {
            id = 1;
            search.engines = {
              "Yandex" = {
                urls = [
                  {
                    template = "https://yandex.ru/search/";
                    params = [
                      {
                        name = "text";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "https://yastatic.net/s3/home-static/_/favicon.ico";
                definedAliases = [ "@ya" ];
              };
            };
            search.default = "Yandex";
            search.force = true;

            settings = {
              "intl.accept_languages" = "ru-RU, ru, en-US, en";
              "browser.startup.homepage" = "https://ya.ru";
              "browser.search.region" = "RU";
              "browser.search.isUS" = false;
              "distribution.searchplugins.defaultLocale" = "ru-RU";
              "general.useragent.locale" = "ru-RU";
            };

            bookmarks = [
              {
                name = "RU сервисы";
                toolbar = true;
                bookmarks = [
                  {
                    name = "Яндекс";
                    url = "https://ya.ru";
                  }
                  {
                    name = "Почта Mail.ru";
                    url = "https://mail.ru";
                  }
                  {
                    name = "VK";
                    url = "https://vk.com";
                  }
                  {
                    name = "Госуслуги";
                    url = "https://www.gosuslugi.ru";
                  }
                  {
                    name = "Сбербанк Онлайн";
                    url = "https://online.sberbank.ru";
                  }
                  {
                    name = "Ozon";
                    url = "https://www.ozon.ru";
                  }
                  {
                    name = "Kinopoisk";
                    url = "https://www.kinopoisk.ru";
                  }
                ];
              }
            ];

            extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
              ublock-origin
              darkreader
              keepassxc-browser
              translate-web-pages
            ];
          };
        };

      };
    };
}
