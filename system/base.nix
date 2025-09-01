{pkgs, lib, config, ...}: {
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
  networking.hostName = "zik-pc";
  hardware.bluetooth.enable = true;
  networking.wireless.iwd.enable = true;
  # networking = {
  #   hostName = "zik-pc";
  #   interfaces.wlan0 = {
  #     useDHCP = true;
  #     ipv4.addresses = [{
  #   address = "62.183.96.183";
  #   prefixLength = 24;  
  # }];
  #  };
  
  #    nameservers = [ "77.88.8.8" "77.88.8.1" ];
  #    defaultGateway = "192.168.0.1";
  #   wireless = {
  #     enable = true;
  #     interfaces = ["wlp3s0"];
  #     networks = {
  #       he-mnie = {
  #         psk = "32412wdsa";
  #       };
  #     };
  #   };
  # };
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

 };
 }
