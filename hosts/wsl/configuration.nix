{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
      ./home.nix
  ];
    services.getty.autologinUser = "zik";
    users.users.zik = {
      isNormalUser = true;
      initialPassword = "121312";
      description = "zik";
      extraGroups = [ "networkmanager" "pipewire" "wheel" "adbusers" "sudoers" "video" "audio" "kvm" "libvirtd" "docker"];
    };
 wsl.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      zik = import ./home.nix;
    };
  };
}
