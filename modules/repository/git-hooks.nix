{ inputs, ... }:
{
  flake-file.inputs.git-hooks-nix.url = "github:cachix/git-hooks.nix";
  imports = [ inputs.git-hooks-nix.flakeModule ];

  perSystem = {
    pre-commit = {
      settings = {
        excludes = [ "template.nix" ];
        hooks = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = false;
          end-of-file-fixer = {
            enable = true;
            excludes = [ "^README\.md$" ];
          };
          trim-trailing-whitespace.enable = true;
          write-files = {
            enable = true;
            entry = "nix run .#write-files";
            pass_filenames = false;
          };
        };
      };
    };
  };
}
