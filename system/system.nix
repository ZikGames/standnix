{pkgs, lib, config, my-packages, ...}: {
 options = {
  base.enable =
 lib.mkEnableOption "the stand of the nix(OS)";
 };
  config = lib.mkIf config.base.enable {
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  console = {
     font = "cyr-sun16";
     keyMap = "ruwin_alt_sh-UTF-8";
   };
   
    # grub
  boot.loader = {
  grub = {
     device = "/dev/sda";
     useOSProber = true;
    
     };
};
boot.supportedFilesystems = ["ntfs" "btrfs"];

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
#   dns = "none";
   };
  networking.nftables.enable = true;
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
#Throne
programs.throne = {
enable = true;
tunMode.enable = true;
};

boot.kernelPackages = pkgs.linuxPackages_zen;
system.stateVersion = "26.05";
 };
 }
