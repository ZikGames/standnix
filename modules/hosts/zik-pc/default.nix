{self, inputs, options, lib, config, ...}: { 
  imports = [
  inputs.home-manager.flakeModules.home-manager
  inputs.flake-parts.flakeModules.easyOverlay
  inputs.flake-parts.flakeModules.modules
  ];
  flake.nixosConfigurations.Zik-PC = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.Zik-PC
    ];
  };
  # flake.homeConfigurations.zik = inputs.nixpkgs.lib.homeConfiguration {
  #   modules = [
  #     self.homeModules.zik
  #     {
  # home = {
  #   username = "zik";
  #   homeDirectory = "/home/zik";
  # };
  # systemd.user.startServices = "sd-switch";
  # home.stateVersion = "24.11";
  #     }
  #   ];
  # }; # не работает
}