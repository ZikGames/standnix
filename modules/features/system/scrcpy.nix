{self, inputs, options, lib, config, ...}: {
flake.nixosModules.scrcpy = {pkgs, ...}: {
users.users.zik.extraGroups = [ "adbusers" ];
environment.systemPackages = with pkgs; [
 scrcpy
 android-tools
];
};
}