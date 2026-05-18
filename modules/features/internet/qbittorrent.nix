{self, inputs, options, lib, config, ...}: {
flake.nixosModules.qbittorrent = {pkgs, outputs, ...}: {
environment.systemPackages = with pkgs; [
  qbittorrent
];
services.qbittorrent = {
enable = true;

};
};
}