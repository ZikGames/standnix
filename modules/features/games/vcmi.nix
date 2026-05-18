{self, inputs, options, lib, config, ...}: {
flake.nixosModules.vcmi = {pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vcmi
  ];
};
}