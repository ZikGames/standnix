{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.kde = { pkgs, lib, ...}: {
  
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager = {
    enable = true;
    };
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kdotool
    kdePackages.plasma-browser-integration
  ];
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    okular 
  ];
  };
  flake.homeModules.kde = { pkgs, lib, ...}: {
    imports = [ inputs.plasma-manager.homeModules.plasma-manager ];
    home.packages = with pkgs; [
      qogir-kde
      qogir-icon-theme
      unrar
      python3
    ];
  programs.plasma = {
    enable = true;
  };
  };
}
