{
  inputs,
  ...
}:
{
  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  flake.nixosModules.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak = {
      enable = true;
      packages = [
        "org.vinegarhq.Vinegar"
        "org.vinegarhq.Sober"
      ];
    };
  };
}
