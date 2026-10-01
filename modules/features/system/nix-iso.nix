{
  self,
  ...
}:
{

  flake.nixosModules.iso =
    {
      pkgs,
      lib,
      ...
    }:
    {

      imports = [
        self.nixosModules.x11
        self.nixosModules.iso-hardware
      ];

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
      users.users.zik = {
        isNormalUser = true;
        initialPassword = "121312";
        description = "zik";
        extraGroups = [
          "networkmanager"
          "pipewire"
          "wheel"
          "video"
          "audio"
        ];
        shell = pkgs.zsh;
      };
      nixpkgs.hostPlatform = "x86_64-linux";
      system.stateVersion = "26.05";

      console.font = "cyr-sun16";
      console.useXkbConfig = true;
      services.xserver.xkb = {
        layout = "us,ru";
        variant = "";
        options = "grp:lalt_lshift_toggle";
      };
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

      environment.systemPackages = with pkgs; [
        ranger
        gparted
        htop-vim
        neovim
      ];

      programs.nix-ld.enable = true;
      console.colors = [
        "1e1e2e" # base
        "181825" # mantle
        "313244" # surface0
        "45475a" # surface1
        "585b70" # surface2
        "cdd6f4" # text
        "f5e0dc" # rosewater
        "b4befe" # lavender
        "f38ba8" # red
        "fab387" # peach
        "f9e2af" # yellow
        "a6e3a1" # green
        "94e2d5" # teal
        "89b4fa" # blue
        "cba6f7" # mauve
        "f2cdcd" # flamingo
      ];
      nix.settings.auto-optimise-store = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      services.getty.autologinUser = lib.mkForce "zik";
      security.sudo.wheelNeedsPassword = false;
      nixpkgs.config.allowUnfree = true;

      # isoImage = {
      #   makeEfiBootable = true;
      #   makeUsbBootable = true;
      #   squashfsCompression = "zstd";
      #   grubTheme = pkgs.minimal-grub-theme;
      # };
      boot.zfs.forceImportRoot = false;

      # image.modules.iso = {
      #   image.baseName = lib.mkForce "labwc-nixos";
      # };
      # image.modules.iso-installer = {
      #   image.fileName = "labwc-nixos-inst";
      # };
    };

  flake.nixosModules.iso-hardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      image.modules.iso = {
        imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];
      };
      boot.initrd.availableKernelModules = [
        "ahci"
        "ohci_pci"
        "ehci_pci"
        "pata_atiixp"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      boot.supportedFilesystems = [
        "ntfs"
        "btrfs"
      ];
    };
}
