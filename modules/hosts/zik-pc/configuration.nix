{self, inputs, options, lib, config, ...}: {

  flake.nixosModules.Zik-PC = { inputs, outputs, pkgs, lib, config, ... }:

{
  imports = [
    self.nixosModules.Zik-PC-hardware
    self.nixosModules.steam 
    self.nixosModules.grub
    self.nixosModules.wayland
    self.nixosModules.zapret
    # self.nixosModules.labwc
    self.nixosModules.kde
    self.nixosModules.home-manager
  ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  console = {
     font = "cyr-sun16";
     keyMap = "ruwin_alt_sh-UTF-8";
   };

# locales
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };
  # network
  hardware.bluetooth.enable = true;
  networking.hostName = "zik-pc";
  networking.networkmanager = {
   enable = true;
   dns = "none";
   };
  networking.nftables.enable = false;
  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 80 443 ];
  allowedUDPPorts = [ 16261 16262 ];
  allowedTCPPortRanges = [
   {
    from = 3030;
    to = 8800;
   }
  ];
  allowedUDPPortRanges = [
  {
    from = 3030;
    to = 8800;
  }
  ];
};

  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
  PasswordAuthentication = true;
  AllowUsers = null;
  UseDns = false;
  X11Forwarding = true;
  PermitRootLogin = "prohibit-password";
  };
 };
  # pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

system.stateVersion = "24.05";
boot.kernelPackages = pkgs.linuxPackages_zen;
  
  services.getty.autologinUser = "zik";
  users.users.zik = {
    isNormalUser = true;
    initialPassword = "121312";
    description = "zik";
    extraGroups = [ "networkmanager" "pipewire" "wheel" "adbusers" "sudoers" "video" "audio" "kvm" "libvirtd" "docker" "terraria" ];
   # shell = pkgs.zsh;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
  };
};
}
