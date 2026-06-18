{self, inputs, options, lib, config, ...}: {
  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  flake.nixosModules.flatpak = {pkgs, imports, ...}: {
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak = {
      enable = true;
      # packages = [
      #   "org.vinegarhq.vinegar"
      #   "org.vinegarhq.Sober"
      # ];
    };
  };
}
