{self, inputs, options, lib, config, ...}: {

perSystem = {pkgs, override, ...}: {
nixpkgs.overlays = [
    (final: prev: {
      bun = prev.bun.overrideAttrs (old: {
        src = prev.fetchurl {
          url = "https://github.com/oven-sh/bun/releases/download/bun-v${old.version}/bun-linux-x64-baseline.zip";
          # hash = lib.fakeHash; 
        };
      });
    })
  ];
};


}