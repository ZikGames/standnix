{ pkgs, lib, config, modulesPath, inputs, ... }: {

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;
  environment.systemPackages = with pkgs; [ 
      labwc
      ranger
      gparted
      waybar
      alacritty
      vim
      waterfox
  ];


}
