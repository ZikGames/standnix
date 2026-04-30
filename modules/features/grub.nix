  {self, inputs, options, lib, config, ...}: {
  flake-file.inputs = { minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  minegrub-world-sel-theme = {
    url = "github:Lxtharia/minegrub-world-sel-theme";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  };
  # perSystem = { pkgs, lib, outputs, ...}: {
  # 
  # };
  flake.nixosModules.grub = { inputs, outputs, pkgs, lib, config, minegrub-theme, minegrub-world-sel-theme, ... }: {
  boot = {
    loader.grub = {
    device = "/dev/sda";
    useOSProber = true;
    # minegrub-theme = {
    #   enable = true;
    #   splash = "100% Flakes!";
    #   background = "background_options/1.8  - [Classic Minecraft].png";
    #   boot-options-count = 4;
    # };
    #   minegrub-world-sel = {
    #   enable = true;
    #   customIcons = with config.system; [
    #     {
    #       inherit name;
    #       lineTop = with nixos; distroName + " " + codeName + " (" + version + ")";
    #       lineBottom = "Survival Mode, No Cheats, Version: " + nixos.release;
    #       # Icon: you can use an icon from the remote repo, or load from a local file
    #       imgName = "nixos";
    #       # customImg = builtins.path {
    #       #   path = ./nixos-logo.png;
    #       #   name = "nixos-img";
    #       # };
    #     }
    #   ];
    # };  
    };
    plymouth = {
      enable = true;
      theme = "spin";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "spin" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
    supportedFilesystems = ["ntfs" "btrfs"];
  };
  };
  }