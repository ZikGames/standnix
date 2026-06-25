{ self, ... }:

{
  # 2. CONFIGURE THE ASPECT (The Dendritic part)
  flake.modules = {

    # Apply to NixOS configurations
    nixos.standnixpkgs = { pkgs, ... }: {
      environment.systemPackages = [
        self.packages.${pkgs.system}.g3m
        # self.packages.${pkgs.system}.dnd
        self.packages.${pkgs.system}.tf2-preloader
      ];
    };
  };
}
