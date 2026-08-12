{
  flake-file.inputs.nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  flake.nixosModules.minecraft =
    {
      pkgs,
      inputs,
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
          compound-v = {
            enable = true;
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
                  packHash = "sha256-11101f0583c6b9efb6ed4470b28f246e3f0756e2024e07f1964e5ed8e6897be3";
                };
              in
              {
                symlinks = {
                  "mods" = "${modpack}/mods";
                };
              };
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
                  path = /home/zik/programs/wiz/dlbeb-surv-server;
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
