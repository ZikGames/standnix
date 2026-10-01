{
  flake-file.inputs.zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  flake.nixosModules.zapret =
    {
      inputs,
      lib,
      ...
    }:
    {
      imports = [ inputs.zapret-discord-youtube.nixosModules.withTestTools ];
      networking.nameservers = [ "::1" ];
      networking.networkmanager.dns = "none";

      services.dnscrypt-proxy = {
        enable = true;
        settings = {
          listen_addresses = [ "[::1]:51" ];
          # ...
        };
      };

      # Forward loopback traffic on port 53 to dnscrypt-proxy2.
      networking.firewall.extraCommands = ''
        ip6tables --table nat --flush OUTPUT
        ${lib.flip (lib.concatMapStringsSep "\n") [ "udp" "tcp" ] (proto: ''
          ip6tables --table nat --append OUTPUT \
            --protocol ${proto} --destination ::1 --destination-port 53 \
            --jump REDIRECT --to-ports 51
        '')}
      '';

      services.zapret-discord-youtube = {
        enable = true;
        # package = withSystem pkgs.stdenv.hostPlatform.system ({ config, ... }:
        #   zapret-discord-youtube.nixosModules.default
        # );
        # configName = "general(ALT)";
        configName = "general(ALT)"; # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)

        # Game Filter: "null" (отключен), "all" (TCP+UDP), "tcp" (только TCP), "udp" (только UDP)
        gameFilter = "all"; # или "all", "tcp", "udp"

        # Добавляем кастомные домены в list-general-user.txt
        listGeneral = [
          "nixos.org"
          "cache.nixos.org"
          "channels.nixos.org"
        ];

        # Добавляем домены в list-exclude-user.txt (исключения)
        listExclude = [
          "ubisoft.com"
          "origin.com"
        ];

        # # Добавляем IP адреса в ipset-all.txt
        # ipsetAll = [
        #   "192.168.1.0/24"
        #   "10.0.0.1"
        # ];

        # # Добавляем IP адреса в ipset-exclude-user.txt (исключения)
        # ipsetExclude = [ "203.0.113.0/24" ];

        # # Необязательно: пользовательские hostlists и конфиги.
        # # extraHostlists может содержать несколько файлов.
        # # Если нужен пример для GitHub, раскомментируйте блок ниже
        # # и оставьте в configName выбранный вами готовый конфиг.
        # extraHostlists."list-github.txt" = [
        #   "github.com"
        #   "api.github.com"
        #   "raw.githubusercontent.com"
        #   "objects.githubusercontent.com"
        #   "githubusercontent.com"
        #   "githubassets.com"
        # ];

        # extraHostlists."list-custom.txt" = [
        #   "example.com"
        #   "example.org"
        # ];

        # nfqwsAppend = [
        #   ''--filter-tcp=443 --hostlist="/opt/zapret/hostlists/list-github.txt" --dpi-desync=multisplit --dpi-desync-split-pos=2''
        # ];
        # # Для полностью ручного конфига можно создать отдельный файл:
        # extraConfigs."my-custom-config" = ''
        #   NFQWS_ENABLE=1
        #   NFQWS_OPT="
        #   --filter-tcp=443 --hostlist="/opt/zapret/hostlists/list-github.txt" --dpi-desync=multisplit --dpi-desync-split-pos=2
        #   "
        # '';
      };
    };
}
