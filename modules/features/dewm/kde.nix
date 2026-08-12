{
  inputs,
  ...
}:
{
  flake-file.inputs.plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };
  flake = {
    nixosModules.kde = { pkgs, ... }: {

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
    homeModules.kde = { pkgs, ... }: {
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
  };
}
