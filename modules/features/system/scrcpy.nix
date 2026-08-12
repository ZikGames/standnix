{
  flake.nixosModules.scrcpy = { pkgs, ... }: {
    users.users.zik.extraGroups = [ "adbusers" ];
    environment.systemPackages = with pkgs; [
      scrcpy
      android-tools
    ];
  };
}
