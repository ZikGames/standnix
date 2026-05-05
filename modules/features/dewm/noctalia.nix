{self, inputs, options, lib, config, ...}: {
  perSystem = { pkgs, lib, ...}: {

    packages.noctalia-cwrapped = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
    };
  };
}