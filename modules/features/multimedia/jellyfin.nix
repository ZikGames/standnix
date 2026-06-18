{self, inputs, options, lib, config, ...}: {
flake.nixosModules.jellyfin = {pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    
  };
};
}