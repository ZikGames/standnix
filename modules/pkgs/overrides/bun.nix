{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake = {
    overlays.bun-baseline = final: prev: {
      bun =
        let
          systemMap = {
            "x86_64-linux" = "linux-x64-baseline";
            "x86_64-darwin" = "darwin-x64-baseline";
          };

          targetArch =
            systemMap.${prev.stdenv.hostPlatform.system}
              or (throw "Unsupported system for bun-baseline overlay");
        in
        {
          bun = prev.bun.overrideAttrs (oldAttrs: {
            src = prev.fetchurl {
              url = "https://github.com/oven-sh/bun/releases/download/bun-v${oldAttrs.version}/bun-${targetArch}.zip";
              hash = prev.lib.fakeHash; # <-- Замените это на реальный хэш после первой ошибки сборки
            };
          });
        };
    };
  };
}
