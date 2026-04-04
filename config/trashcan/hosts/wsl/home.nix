{ config, pkgs, ... }:

{
  # Home Manager settings
  home.username = "your-username";
  home.homeDirectory = "/home/your-username";

  # Packages to install
  home.packages = with pkgs; [
    # Core utilities
    wget
    curl
    git
    htop
    neovim

    # WSL-specific utilities
    wslu  # Provides wslopen, wslview, etc.

    # Development tools
    gcc
    python3
    nodejs
  ];

  # Program configurations
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Zik";
    userEmail = "zik1213@outlook.com";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}