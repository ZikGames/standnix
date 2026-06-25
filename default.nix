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
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
    mainProgram = "dnd-gunter";
    platforms = lib.platforms.all;
  };
})
