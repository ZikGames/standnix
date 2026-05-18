{self, inputs, options, lib, config, ...}: {
flake.homeModules.thunderbird = {pkgs, outputs, ...}: {
programs.thunderbird = {
  enable = true;
};
};
}