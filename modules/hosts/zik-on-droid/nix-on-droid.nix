{self, inputs, options, lib, config, ...}: {

flake.nixosModules.nix-on-droid = { config, lib, pkgs, ... }:

{
imports = [
  self.nixosModules.x11
];
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    neovim # or some other editor, e.g. nano or neovim
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

    # Some common stuff that people expect to have
    #procps
    #killall
    #diffutils
    #findutils
    #utillinux
    #tzdata
    #hostname
    #man
    #gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    #zip
    #unzip
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Europe/Moscow";

  # Configure home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
  };
};
flake.homeModules.zik-on-droid = { config, lib, pkgs, ... }:

{
  # Read the changelog before changing this value
  home.stateVersion = "24.05";

  # insert home-manager config
};
}
