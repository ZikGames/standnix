{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.bottles = { pkgs, ... }: {
    # nixpkgs.overlays = [
    #   (_: prev: {
    #     openldap = prev.openldap.overrideAttrs {
    #       doCheck = !prev.stdenv.hostPlatform.isi686;
    #     };
    #   })
    # ];
    environment.systemPackages = with pkgs; [
      (bottles.override { removeWarningPopup = true; })
    ];
  };
}
