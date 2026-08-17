{
  flake.nixosModules.mihomo = { pkgs, ... }: {
    services.mihomo = {
      enable = true;
      tunMode = true;
      configFile = ./mihomo.yaml;
      webui = pkgs.metacubexd;
    };
  };
}
