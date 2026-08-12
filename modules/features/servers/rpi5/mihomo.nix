{
  flake.nixosModules.mihomo = {
    services.mihomo = {
      enable = true;
      # configFile = "/path/to/config.yaml";
      #...
    };
  };
}
