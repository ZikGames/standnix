{ self, inputs, ... }:
{
  flake.flake-file.inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  flake.nixosModules.nix-wsl = { pkgs, ... }: {
    system.stateVersion = "25.05";
    wsl.enable = true;
  };
}
