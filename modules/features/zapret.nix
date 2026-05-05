{self, inputs, options, ...}: {
  flake-file.inputs.zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";  
  flake.nixosModules.zapret = { inputs, pkgs, lib, config, ... }: {
  networking.nameservers = [ "::1" ];

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
      config = "general(ALT11)";  # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
            
      # Game Filter: "null" (отключен), "all" (TCP+UDP), "tcp" (только TCP), "udp" (только UDP)
      gameFilter = "all";  # или "all", "tcp", "udp"
    };
  };
}