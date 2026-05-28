{self, inputs, options, lib, config, ...}: {
flake.nixosModules.qbittorrent = {pkgs, outputs, ...}: {
services.qbittorrent = {
enable = true;
user = "zik";
};
};
}