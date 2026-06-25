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

    packages.dnd-gunter = pkgs.callPackage (
      {
        lib,
        stdenv,
        fetchFromGitHub,
        nix-update-script,
      }:

      stdenv.mkDerivation (finalAttrs: {
        pname = "dnd-gunter";
        version = "12.5";
        __structuredAttrs = true;
        strictDeps = true;

        src = fetchFromGitHub {
          owner = "ZikGames";
          repo = "dnd-gunter";
          tag = finalAttrs.version;
          hash = "sha256-r0cpPovTGxAhZerxCrokQuNvy9bdEAkoGLo6323leJA=";
        };

        passthru.updateScript = nix-update-script { };

        meta = {
          description = "Dnd- but madmanwith(out)thebox in control";
          homepage = "https://github.com/ZikGames/dnd-gunter";
          license = lib.licenses.mit;
          mainProgram = "dnd-gunter";
          platforms = lib.platforms.all;
        };
      })
    );
  };
}
