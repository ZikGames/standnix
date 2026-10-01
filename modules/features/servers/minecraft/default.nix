{
  flake-file.inputs.nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  flake.nixosModules.minecraft =
    {
      pkgs,
      inputs,
      # lib,
      ...
    }:
    {
      imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
      nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
      users.users.zik.extraGroups = [ "minecraft" ];
      services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        dataDir = "/var/lib/minecraft-servers";
        servers = {

          icarus-menu-wiund = {
            enable = false;
            package = pkgs.neoforgeServers.neoforge-1_21_1.override { jre_headless = pkgs.openjdk25_headless; };
            serverProperties = {
              allow-flight = true;
              server-port = 6636;
              difficulty = 2;
              gamemode = 0;
              max-players = 6;
              motd = "lelele";
              white-list = false;
              online-mode = false;
              allow-cheats = false;
              #    world-seed = 5289485976029100916;
              max-world-size = 35000;
            };
            # symlinks = {
            #   # "mods" = "/home/zik/.local/share/PrismLauncher/instances/Icarus_Server-1.0.0/minecraft/mods/";
            # };
            symlinks =
              let
                # pack = builtins.path {
                #   path = /home/zik/programs/nix/wiz/dlbeb-create-server;
                # };
                modpack = pkgs.fetchPackwizModpack {
                  # url = "file://${pack}/pack.toml";
                  url = "https://raw.githubusercontent.com/ZikGames/minecraft-modpacks/refs/heads/main/icarus_server/pack.toml";
                  # packHash = lib.fakeSha256; # раскомментить при необходимости обновления
                  packHash = "sha256-HcizW7Y5k4s6zhbWbMRqGc4fyjP9ts7oIfYfQdqWDiA="; # раскомментить при необходимости кое какого персиста между обновлениями
                };
              in
              {
                "mods" = "${modpack}/mods";
              };

            jvmOpts = "-Xms8192M -Xmx8192M -XX:+UseG1GC"; # настраивай как нибудь сам
          };

          rwl = {
            enable = false;
            package = pkgs.fabricServers.fabric-26_2.override { jre_headless = pkgs.openjdk25_headless; };
            serverProperties = {
              allow-flight = true;
              server-port = 5432;
              difficulty = 2;
              gamemode = 0;
              max-players = 3;
              motd = "il";
              white-list = false;
              online-mode = true;
              allow-cheats = false;
              #    world-seed = 5289485976029100916;
              max-world-size = 35000;
            };
            # symlinks =
            # let
            #   modpack = pkgs.fetchPackwizModpack {
            #     url = "https://github.com/ZikGames/minecraft-modpacks/raw/refs/heads/main/rwl/pack.toml";
            #   };
            # in
            # {
            # "mods" = "${modpack}/mods";
            # "mods" = "/home/zik/.local/share/PrismLauncher/instances/Rwl-1.0.0/minecraft/mods/";
            # };
            jvmOpts = "-Xms4096M -Xmx4096M -XX:+UseG1GC -Djava.net.preferIPv4Stack=true";
          };

          compound-v = {
            enable = false;
            package = pkgs.neoforgeServers.forge-1_21_1.override { jre_headless = pkgs.openjdk25_headless; };
            serverProperties = {
              allow-flight = true;
              server-port = 6535;
              difficulty = 2;
              gamemode = 0;
              max-players = 5;
              motd = "test";
              white-list = false;
              online-mode = false;
              allow-cheats = false;
              #    world-seed = 5289485976029100916;
              max-world-size = 35000;
            };
            symlinks =
              let
                modpack = pkgs.fetchPackwizModpack {
                  url = "https://github.com/ZikGames/minecraft-modpacks/compound_v-server/pack.toml";
                  packHash = "11101f0583c6b9efb6ed4470b28f246e3f0756e2024e07f1964e5ed8e6897be3";
                };
              in
              {
                "mods" = "${modpack}/mods";
              };
            jvmOpts = "-Xms8192M -Xmx8192M -XX:+UseG1GC";
          };

          dlbeb-create = {
            enable = false;
            package = pkgs.neoforgeServers.neoforge-1_21_1.override { jre_headless = pkgs.openjdk25_headless; };
            serverProperties = {
              allow-flight = true;
              server-port = 6535;
              difficulty = 3;
              gamemode = 0;
              max-players = 5;
              motd = "Долбаёбы криэйт аэронаутикс (и не только)";
              white-list = false;
              online-mode = false;
              allow-cheats = false;
              #    world-seed = 5289485976029100916;
              max-world-size = 35000;
            };
            symlinks =
              let
                createPack = builtins.path {
                  path = /home/zik/programs/nix/wiz/dlbeb-create-server;
                };
                modpack-create = (
                  pkgs.fetchPackwizModpack {
                    url = "file://${createPack}/pack.toml";
                    packHash = "a013c3fa1887106ca4c032dacee64f4b85e471f81d924a1dbea943912d05bcf3";
                    side = "server";
                  }
                );
              in
              {
                "mods" = "${modpack-create}/mods";
              };
            files = {
              "config" = "/home/zik/.local/share/PrismLauncher/instances/dlbeb 1.21.1/minecraft/config";
            };
            jvmOpts = "-Xms8036M -Xmx8036M -XX:+UseG1GC -Djava.locale.providers=JRE";
          };

          dlbeb-surv = {
            enable = false;
            package = pkgs.fabricServers.fabric-26_1_2.override { jre_headless = pkgs.openjdk25_headless; };
            serverProperties = {
              allow-flight = true;
              server-port = 6536;
              difficulty = 3;
              gamemode = 0;
              max-players = 5;
              motd = "сурвайв приколюхи";
              white-list = false;
              online-mode = false;
              allow-cheats = false;
              # world-seed = ;
              max-world-size = 35000;
            };
            symlinks =
              let
                survPack = builtins.path {
                  path = /home/zik/programs/nix/wiz/dlbeb-surv-server;
                };
                modpack-surv = (
                  pkgs.fetchPackwizModpack {
                    url = "file://${survPack}/pack.toml";
                    packHash = "fde62a8530a0eb33ad128992bfdc33fd7ada4485d7e9e60d82180fe8869e3ccb";
                    side = "server";
                  }
                );
              in
              {
                "mods" = "${modpack-surv}/mods";
              };
            files = {
              "config" = "/home/zik/.local/share/PrismLauncher/instances/dlbeb 26.1.2 server/minecraft/config";
            };
            jvmOpts = "-Xms2048M -Xmx2048M -XX:+UseG1GC -Djava.locale.providers=JRE";
          };
        };
      };
    };
}
