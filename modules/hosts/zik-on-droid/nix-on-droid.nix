{
  self,
  inputs,
  ...
}:
{

  flake-file.inputs = {
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixgl.url = "github:nix-community/nixGL";
  };
  flake.nixOnDroidConfiguration.nix-on-droid =
    {
      ...
    }:

    {

    };
  flake.nixOnDroidModules.zik =
    {
      pkgs,
      ...
    }:

    {
      imports = [
        # self.homeModules.prismlauncher
        # self.homeModules.keepassxc
        # self.homeModules.nixcord
        # self.homeModules.vscode
        # self.homeModules.kde
        # self.homeModules.thunderbird
        # self.homeModules.freetube
        # self.homeModules.ytmdesktop
        # self.homeModules.firefox
        # self.homeModules.vlc
        # self.homeModules.koreader
        # self.homeModules.zed
        self.nixosModules.tuifimanager
        self.nixosModules.x11
      ];
      # Simply install just the packages
      environment.packages = with pkgs; [
        # User-facing stuff that you really really want to have
        # neovim # or some other editor, e.g. nano or neovim
        neovim
        inputs.nixGL.packages.aarch64-linux.default
        mesa.drivers
        vulkan-tools
        vulkan-tools-lunarg
        vulkan-headers
        vulkan-loader
        vulkan-loader.dev
        vulkan-validation-layers
        vulkan-extension-layer
        shaderc
        openssh
        zsh-nix-shell
      ];

      # Backup etc files instead of failing to activate generation if a file already exists in /etc
      environment.etcBackupExtension = ".bak";

      # Read the changelog before changing this value
      system.stateVersion = "24.05";

      # Set up nix for flakes
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      # # Set your time zone
      time.timeZone = "Europe/Moscow";

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
      };
      programs.git = {
        enable = true;
        settings.user = {
          name = "Zik1213";
          email = "zik1213@outlook.com";
        };
      };
    };
}
