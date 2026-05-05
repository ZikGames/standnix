{self, inputs, options, ...}: {
  flake-file.inputs.zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";  
  flake.nixosModules.zapret = { inputs, pkgs, lib, config, ... }: {

    services.zapret-discord-youtube = {
      enable = false;
      # package = withSystem pkgs.stdenv.hostPlatform.system ({ config, ... }:
      #   zapret-discord-youtube.nixosModules.default
      # );
      config = "general";  # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
            
      # Game Filter: "null" (отключен), "all" (TCP+UDP), "tcp" (только TCP), "udp" (только UDP)
      gameFilter = "udp";  # или "all", "tcp", "udp"
    };
  };
}