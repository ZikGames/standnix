{self, inputs, options, lib, config, ...}: {
flake.nixosModules.bottles = {pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (bottles.override {removeWarningPopup = true;})
  ];
};
}