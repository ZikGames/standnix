{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.windowmaker = { pkgs, lib, ...}: {
  services.xserver.windowManager.windowmaker.enable = true;
  };
   flake.homeModules.windowmaker = { pkgs, lib, ...}: {
      home.packages = with pkgs; [
      dockapps.wmsystemtray
    ];
};
}