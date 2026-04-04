{attributes, pkgs, etc, ...}: {
 
 options = {
  trashcan.enable =
  lib.mkEnableOption "fuckin trashcan for unused now, but used past";
};
  config = lib.mkIf config.trashcan.existense {

from."flake.nix" = {
        zik-wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/wsl/configuration.nix
          ./programs
        nixos-wsl.nixosModules.default
        inputs.home-manager.nixosModules.default
        ];
      };

};
from."system/system.nix" = {
 # networking.wireless.iwd.enable = true;
 # networking = {
 #   hostName = "zik-pc";
 #   interfaces.wlan0 = {
 #     useDHCP = true;
 #     ipv4.addresses = [{
 #   address = "62.183.96.183";
 #   prefixLength = 24;
 # }];
 #  };
 #  };
  #   wireless = {
  #     enable = true;
  #     interfaces = ["wlp3s0"];
  #     networks = {
  #       he-mnie = {
  #         psk = "32412wdsa";
  #       };
  #     };
  #   };
  # };
#  networking.nameservers = [ "::1" ];
#  services.dnscrypt-proxy = {
#    enable = true;
#    settings = {
#      listen_addresses = [ "[::1]:51" ];
#      ipv4_servers = true;
#    };
#  };


  # Forward loopback traffic on port 53 to dnscrypt-proxy2.
  # networking.firewall.extraCommands = ''
  #   ip6tables --table nat --flush OUTPUT
  #   ${lib.flip (lib.concatMapStringsSep "\n") [ "udp" "tcp" ] (proto: ''
  #     ip6tables --table nat --append OUTPUT \
  #       --protocol ${proto} --destination ::1 --destination-port 53 \
  #       --jump REDIRECT --to-ports 51
  #   '')}
  # '';
};
from."system/wayland.nix" = {
   environment.systemPackages = with pkgs; [
  	# kdePackages.xwaylandvideobridge
   ];
};
from."system/steam.nix" = {
  programs.steam = {
  #  package = pkgs.steam-millennium;
  };
  # hardware.graphics = {
#   extraPackages = [ pkgs.amdvlk ];
#   extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
# }; # deprecated
# #i am with invidia (GTX 1060) now 20/02/2026
};
from."programs/discord.nix" = {
   programs.nixcord = {

    config = {
      themeLinks = [ 
        ""
#https://raw.githubusercontent.com/otsegolo/system24-catppuccin-macchiato-red/refs/heads/main/theme/flavors/system24-catppuccin-macchiato.theme.css
        ""
      ];
      plugins = [
              #   CustomRPC = {
      #     enable = true;
      #     config = {
      #     appID = "1058352493676986378";
      #     appName = "madness";
      #     buttonOneText = "beep";
      #     buttonOneURL = "https://soundcloud.com/999plus/go-light-up-collective-consciousness";
      #     buttonTwoText = "boop";
      #     buttonTwoURL = "https://soundcloud.com/awildzapdos/gaster-theme-undertale";
      #     details = "hello";
      #     imageBig = "https://media.tenor.com/1y8zDc-ll-EAAAAM/3d-saul-saul-goodman.gif";
      #     imageBigTooltip = "o/";
      #     imageSmall = "https://media.tenor.com/XZrktrRnsOYAAAAM/alan-wake-2-alan-wake.gif";
      #     imageSmallTooltip = "/o";
      #     state = "";
      #     timestampMode = "discordUptime";
      #   #  startTime = "1759276800";
      #   #  endTime = "1761955200";
      #     type = "watching";
      #     };
      # };
      ]
}
};

};
