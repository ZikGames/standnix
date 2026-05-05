 {self, inputs, options, ...}: {
  flake.nixosModules.home-manager = { pkgs, lib, options, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      zik = import self.homeModules.zik;
    };
  };
 };
 }