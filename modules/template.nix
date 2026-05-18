{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.template = {}: {};
  flake.homeModules.template = {}: {};
  perSystem = { pkgs, lib, ...}: {

    packages.template-cwrapped = inputs.wrapper-modules.wrappers.template.wrap {

    };

  };
}