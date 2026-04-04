{ inputs, outputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
  ];
  
  services.getty.autologinUser = "zik";
  users.users.zik = {
    isNormalUser = true;
    initialPassword = "121312";
    description = "zik";
    extraGroups = [ "networkmanager" "pipewire" "wheel" "adbusers" "sudoers" "video" "audio" "kvm" "libvirtd" "docker" "terraria" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      zik = import ./home.nix;
    };
  };
}
