{self, inputs, options, lib, config, ...}: {
flake.nixosModules.scrcpy = {pkgs, ...}: {
environment.systemPackages = with pkgs; [
 scrcpy
 android-tools
];
};
}