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
        ./zapret.nix
		./yandex-browser.nix
	    ./xfce.nix
        ./wine.nix
        ./waydroid.nix

    ];
    grub.enable = true;
    labwc.enable = true;
    locales.enable = true;
    network.enable = true;
    steam.enable = true;
    pipewire.enable = true;
    zerotier.enable = false;
    zsh.enable = true;
    wayland.enable = true;
    zapret.enable = true;
	yandex-browser.enable = true;
	xfce.enable = false;
    wine.enable = true;
    waydroid.enable = true;
}
