{pkgs, lib, config, ...}: {
    imports = [
        ./grub.nix
        ./labwc.nix
        ./locales.nix
        ./network.nix
        ./steam.nix
        ./pipewire.nix
        ./zerotier.nix
        ./zsh.nix
        ./wayland.nix

    ];
    grub.enable = true;
    labwc.enable = false;
    locales.enable = true;
    network.enable = true;
    steam.enable = true;
    pipewire.enable = true;
    zerotier.enable = false;
    zsh.enable = true;
    wayland.enable = true;

}