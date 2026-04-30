{self, inputs, lib, config, ...}: 
  {
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    naersk.url = "github:nix-community/naersk";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
 options = {
  rust-devshell.enable =
 lib.mkEnableOption "why not? =]";
 };
  config = lib.mkIf config.rust-devshell.enable {
  perSystem = { self, nixpkgs, naersk, fenix }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    naerskLib = pkgs.callPackage naersk {};
    fenixLib = fenix.packages."x86_64-linux";
    rustToolChain = fenixLib.complete.toolchain;
  in {
    devShells.rust = pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo rustc rustfmt clippy rust-analyzer glib rustToolChain openssl
      ];
    nativeBuildInputs = [ pkgs.pkg-config ];
    env.RUST_SRC_PATH = "@{pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
    packages."x86_64-linux".default = naerskLib.buildPackage {
    name = "dnd";
    src = "./dnd-rust/";
     buildInputs = [];
     nativeBuildInputs = [ pkgs.pkg-config ];
  };
  };
  };
  }