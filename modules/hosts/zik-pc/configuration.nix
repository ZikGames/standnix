{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{

  flake.nixosModules.Zik-PC =
    {
      inputs,
      outputs,
      pkgs,
      lib,
      config,
      ...
    }:

    {
      imports = [
        self.nixosModules.Zik-PC-hardware
        self.nixosModules.steam
        self.nixosModules.grub
        self.nixosModules.wayland
        self.nixosModules.throne
        # self.nixosModules.zapret
        # self.nixosModules.server-mode
        self.nixosModules.wine
        self.nixosModules.fallout2
        self.nixosModules.heroic
        self.nixosModules.limo
        self.nixosModules.openmw
        self.nixosModules.scrcpy
        # self.nixosModules.openxray
        self.nixosModules.vcmi
        self.nixosModules.nitter
        self.nixosModules.qbittorrent
        self.nixosModules.vintagestory
        self.nixosModules.qemu
        self.nixosModules.bottles
        self.nixosModules.kde
        self.nixosModules.flatpak
        # self.nixosModules.jellyfin
        # self.nixosModules.standnixpkgs
        self.nixosModules.waydroid
      ];
      nix.settings.auto-optimise-store = true;
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      console = {
        font = "cyr-sun16";
        keyMap = "ruwin_alt_sh-UTF-8";
      };

      # locales
      time.timeZone = "Europe/Moscow";
      i18n.defaultLocale = "ru_RU.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "ru_RU.UTF-8";
        LC_IDENTIFICATION = "ru_RU.UTF-8";
        LC_MEASUREMENT = "ru_RU.UTF-8";
        LC_MONETARY = "ru_RU.UTF-8";
        LC_NAME = "ru_RU.UTF-8";
        LC_NUMERIC = "ru_RU.UTF-8";
        LC_PAPER = "ru_RU.UTF-8";
        LC_TELEPHONE = "ru_RU.UTF-8";
        LC_TIME = "ru_RU.UTF-8";
      };
      # network
      hardware.bluetooth.enable = true;
      networking.interfaces.enp4s0 = {
        ipv4.addresses = [
          {
            address = "192.168.1.10";
            prefixLength = 24;
          }
        ];
      };
      networking.hostName = "zik-pc";
      networking.networkmanager = {
        enable = true;
        #  dns = "dnsmasq";
      };
      networking.nameservers = [
        "77.88.8.8"
        "77.88.8.1"
      ];
      networking.firewall = {
        enable = true;
        backend = "iptables";
        allowedTCPPorts = [
          80
          443
          59100
        ];
        allowedUDPPorts = [
          16261
          16262
          59100
          59200
        ];
        allowedTCPPortRanges = [
          {
            from = 3030;
            to = 8800;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 3030;
            to = 8800;
          }
        ];
      };

      programs.ssh.startAgent = true;
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        openFirewall = true;
        settings = {
          PasswordAuthentication = true;
          # AllowUsers = null;
          UseDns = false;
          X11Forwarding = true;
          PermitRootLogin = "prohibit-password";
        };
      };
      # pipewire
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      system.stateVersion = "24.05";
      boot.kernelPackages = pkgs.linuxPackages_zen;
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        ohMyZsh = {
          enable = true;
          plugins = [
            "git"
            "vi-mode"
          ];
          theme = "gallifrey";
        };
      };
      environment.systemPackages = with pkgs; [
        zsh-nix-shell
        pulseaudio
      ];
      services.getty.autologinUser = "zik";
      users.users.zik = {
        isNormalUser = true;
        initialPassword = "121312";
        description = "zik";
        extraGroups = [
          "networkmanager"
          "pipewire"
          "wheel"
          "sudoers"
          "video"
          "audio"
        ];
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
      };
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = false;
      };
    };
  flake.homeModules.zik =
    {
      inputs,
      outputs,
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.homeModules.prismlauncher
        self.homeModules.keepassxc
        self.homeModules.firefox
        self.homeModules.nixcord
        # self.homeModules.vscode
        self.homeModules.kde
        self.homeModules.thunderbird
        self.homeModules.freetube
        self.homeModules.vlc
        self.homeModules.koreader
        self.homeModules.ytmdesktop
        self.homeModules.zed
      ];
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = /home/zik/standnix;
      };

      programs.mangohud = {
        enable = true;
        # settings = [
        #  engine_version
        #  gpu_name
        #  wine
        #  ];
      };

      programs.git = {
        enable = true;
        settings = {
          credential.helper = "keepassxc";
          user = {
            name = "Zik1213";
            email = "zik1213@outlook.com";
          };
        };
      };

      home = {
        username = "zik";
        homeDirectory = "/home/zik";
      };
      systemd.user.startServices = "sd-switch";
      home.stateVersion = "24.11";

      home.packages = with pkgs; [
        steam-run
        dotnet-sdk_8
        nix-ld
      ];
    };

}
