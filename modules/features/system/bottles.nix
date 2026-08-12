{
  flake.nixosModules.bottles = { pkgs, ... }: {
    nixpkgs.overlays = [
      (_final: prev: {
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (_python-final: python-prev: {
            patool = python-prev.patool.overrideAttrs (_: {
              doCheck = false;
            });
          })
        ];
      })
    ];
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
