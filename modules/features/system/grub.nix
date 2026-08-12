{
  flake-file.inputs.minegrub-theme.url = "github:Lxtharia/minegrub-theme";

  flake.nixosModules.grub =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.minegrub-theme.nixosModules.default ];
      boot = {
        loader.grub = {
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
          extraConfig = ''
            GRUB_DISABLE_OS_PROBER=false
          '';
          minegrub-theme = {
            enable = true;
            splash = "100% Flakes!";
            background = "background_options/1.8  - [Classic Minecraft].png";
            boot-options-count = 4;
          };
        };
        plymouth = {
          enable = true;
          theme = "connect";
          themePackages = with pkgs; [
            # By default we would install all themes
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "connect" ];
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
        loader.timeout = 5;
        supportedFilesystems = [
          "ntfs"
          "btrfs"
        ];
      };
    };
}
