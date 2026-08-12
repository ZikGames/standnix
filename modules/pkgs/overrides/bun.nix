# modules/pkgs/overrides/bun.nix
{
  perSystem =
    { config, pkgs, ... }:
    {
      packages.bun-baseline = pkgs.callPackage (
        {
          lib,
          stdenvNoCC,
          fetchurl,
          autoPatchelfHook,
          unzip,
          installShellFiles,
          makeWrapper,
          openssl,
        }:
        stdenvNoCC.mkDerivation (finalAttrs: {
          pname = "bun-baseline";
          version = "1.3.13"; # keep in sync with pkgs.bun.version

          src = fetchurl {
            url = "https://github.com/oven-sh/bun/releases/download/bun-v${finalAttrs.version}/bun-linux-x64-baseline.zip";
            hash = "sha256-nYokKSpwaAkCBdqsCloiP19pc29Sh+N7+I07QDHtx1A=";
          };

          strictDeps = true;
          nativeBuildInputs = [
            unzip
            installShellFiles
            makeWrapper
            autoPatchelfHook
          ];
          buildInputs = [ openssl ];

          dontConfigure = true;
          dontBuild = true;

          installPhase = ''
            runHook preInstall
            install -Dm755 ./bun $out/bin/bun
            ln -s $out/bin/bun $out/bin/bunx
            runHook postInstall
          '';

          meta = {
            description = "Incredibly fast JavaScript runtime, bundler, transpiler and package manager (baseline build, no AVX2 required)";
            homepage = "https://bun.sh";
            license = with lib.licenses; [
              mit
              lgpl21Only
            ];
            mainProgram = "bun";
            platforms = [ "x86_64-linux" ];
          };
        })
      ) { };
      overlayAttrs = {
        inherit (config.packages) bun-baseline;
        bun = config.packages.bun-baseline;
      };
    };
}
