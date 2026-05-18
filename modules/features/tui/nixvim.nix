{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.template = {pkgs, ...}: {};
  flake.homeModules.template = {}: {};
  perSystem = { pkgs, lib, ...}: {

    packages.nixvim-cwrapped = inputs.wrapper-modules.wrappers.nixvim.wrap {

    };

  };
}