{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
   inputs.nixcord.homeModules.nixcord
   inputs.nix-colors.homeManagerModules.default
   plasma-manager.homeModules.plasma-manager
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "zik";
    homeDirectory = "/home/zik";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
   home.packages = with pkgs; [ steam-run ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
