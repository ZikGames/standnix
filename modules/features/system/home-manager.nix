{
  self,
  ...
}:
{
  flake-file.inputs.home-manager.url = "github:nix-community/home-manager";
  flake.nixosModules.home-manager =
    {
      inputs,
      outputs,
      ...
    }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = { inherit inputs outputs; };
        users = {
          zik = {
            imports = [ self.homeModules.zik ];
          };
        };
      };
    };
}
