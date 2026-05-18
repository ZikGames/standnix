{ self, inputs, pkgs, ... }:
{
  flake-file.inputs.firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  flake.homeModules.firefox = { inputs, outputs, pkgs, lib, config, ... }: {
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
        "Яндекс" = {
          urls = [{
            template = "https://yandex.com/search/?text={searchTerms}";
          }];
          icon = "https://upload.wikimedia.org/wikipedia/commons/5/58/Yandex_icon.svg";
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

#   bookmarks = {
# 	  force = false;
# };

      settings = {
      };

      userChrome = ''                         
        /* some css */                        
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

  };
};
}