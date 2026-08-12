{ inputs, ... }:
{
  flake-file.inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  flake.nixosModules.nix-wsl = {
    imports = [ inputs.nixos-wsl.nixosModules.wsl ];
    system.stateVersion = "25.05";
    wsl.enable = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
