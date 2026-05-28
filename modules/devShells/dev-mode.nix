{self, inputs, options, lib, config, ...}: {
  imports = [
    inputs.rust-flake.flakeModules.default
    inputs.rust-flake.flakeModules.nixpkgs
  ];
  flake.nixosModules.dev-mode = {pkgs, lib, imports, ...}: {
    imports = [
      self.nixosModules.zkdl
      self.nixosModules.rust
      self.nixosModules.CSharp
    ];
  };
}
