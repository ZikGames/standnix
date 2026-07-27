{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  # flake.flake-file.inputs.
  flake.nixosModules.server-mode =
    {
      pkgs,
      options,
      lib,
      ...
    }:
    {
      specialisation.server = {
        inheritParentConfig = false;
        configuration = {
          imports = [
            self.nixosModules.minecraft
            self.nixosModules.grub
            self.nixosModules.Zik-PC-hardware
          ];
          environment.systemPackages = with pkgs; [
            jdk25_headless
          ];
          users.users.zik = {
            isNormalUser = true;
            description = "zik";
            extraGroups = [
              "networkmanager"
              "pipewire"
              "wheel"
              "sudoers"
              "video"
              "audio"
            ];
            shell = pkgs.zsh;
            ignoreShellProgramCheck = true;
          };
        };
      };
    };
}
