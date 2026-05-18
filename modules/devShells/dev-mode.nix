{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.dev-mode = {pkgs, lib, imports, ...}: {
    imports = [
      self.nixosModules.zkdl
      self.nixosModules.rust
      self.nixosModules.CSharp
    ];
  };
}