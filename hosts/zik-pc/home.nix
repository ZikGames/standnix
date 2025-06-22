# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.default

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ../../modules/home-manager
    inputs.plasma-manager.homeManagerModules.plasma-manager
   # inputs.labwc-manager.homeManagerModule.default
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
  # home.packages = with pkgs; [ steam ];

  programs.firefox.enable = false;
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
