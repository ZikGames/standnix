{self, inputs, options, lib, config, ...}: {
  options = {
  noctalia-shell.enable =
  lib.mkEnableOption "noctalia";
 };
  config = lib.mkIf config.noctalia-shell.enable {
  perSystem = { pkgs, lib, ...}: {

    packages.noctalia-cwrapped = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
    };
  };
};
}