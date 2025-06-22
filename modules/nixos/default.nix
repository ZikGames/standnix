{pkgs, lib, config, ...}: {
    imports = [
 # system
./locales.nix
./grub.nix
./pipewire.nix
./wayland.nix
./zsh.nix
 # network
 ./network.nix
 ./zerotier.nix
 #./zapret.nix
 ./v2ray.nix
  # DE/WM
  ./kde.nix
  ./xfce.nix
  ./labwc.nix
  ./gnome.nix
   # user
   ./nix-clean.nix
   ./android.nix

    # apps
   ./steam.nix
   #./yandex-browser.nix
   ./qemu.nix
   ./wine.nix
    ];

grub.enable = true;
locales.enable = true;
pipewire.enable = true;
wayland.enable = true;
zsh.enable = true;

network.enable = true;
zerotier.enable = false;
#zapret.enable = false;
#v2ray.enable = true;

labwc.enable = true;
kde.enable = false;
xfce.enable = false;
gnome.enable = true;

android.enable = true;
steam.enable = true;
#yandex-browser.enable = false;
qemu.enable = true;
wine.enable = true;
}
