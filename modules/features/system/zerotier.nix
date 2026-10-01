{
  flake.nixosModules.zerotier = {

    services.zerotierone = {
      enable = true;
      joinNetworks = [
        "fada62b0154ed26c"
        "af415e486f3487c3"
        "8d1c312afa36a05e"
      ];
    };
  };
}
