{
  flake.nixosModules.windowmaker = {
    services.xserver.windowManager.windowmaker.enable = true;
  };
  flake.homeModules.windowmaker = { pkgs, ... }: {
    home.packages = with pkgs; [
      dockapps.wmsystemtray
    ];
  };
}
