{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  perSystem = { pkgs, lib, ... }: {

    packages.tf2-preloader = pkgs.callPackage (
      {
        lib,
        stdenv,
        fetchFromGitHub,
        nix-update-script,
      }:

      stdenv.mkDerivation (finalAttrs: {
        pname = "casual-pre-loader";
        version = "2.2.1";
        __structuredAttrs = true;
        strictDeps = true;

        src = fetchFromGitHub {
          owner = "cueki";
          repo = "casual-pre-loader";
          tag = "v${finalAttrs.version}";
          hash = "sha256-kBflXzUd7IJ32mVzdw0QQ+xQYscfmCes1VbyYz2Xr2Y=";
        };

        passthru.updateScript = nix-update-script { };

        meta = {
          description = "TF2 particle modifications via some wizardry";
          homepage = "https://github.com/cueki/casual-pre-loader";
          changelog = "https://github.com/cueki/casual-pre-loader/releases/tag/${finalAttrs.src.tag}";
          license = lib.licenses.gpl3Only;
          # maintainers = with lib.maintainers; [ ];
          mainProgram = "casual-pre-loader";
          platforms = lib.platforms.all;
        };
      })
    ) { };
  };
}
