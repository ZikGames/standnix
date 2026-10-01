{
  flake.nixosModules.mihomo =
    { pkgs, ... }:
    let
      geoipMetadb = pkgs.fetchurl {
        url = "https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip.metadb";
        sha256 = "xP0ProFgAd3L9SYbVHpMygMMCIGtpSE4XFNWmhw8uRw=";
        # url = "file:///home/zik/Загрузки/geoip.metadb";
      };
    in
    {
      services.mihomo = {
        enable = true;
        tunMode = false;
        configFile = ./mihomo.yaml;
        webui = pkgs.metacubexd;
      };

      systemd.services.mihomo.preStart = ''
        install -Dm644 ${geoipMetadb} /var/lib/private/mihomo/geoip.metadb
      '';
    };
}
