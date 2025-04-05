{
  description = "A very basic flake serving utreexod as a package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = (import nixpkgs { inherit system; });
      in
      {
        packages = rec {
          default = (
            pkgs.buildGoModule {
              pname = "utreexod";
              version = "0.4.1";
              vendorHash = "sha256-gZADkexHFUqcPVN7ImV9E8h/K/DgmL1CqMWUY2t8lDM=";
              src = pkgs.fetchFromGitHub {
                owner = "utreexo";
                repo = "utreexod";
                rev = "v0.4.1";
                sha256 = "sha256-oC+OqRuOp14qW2wrgmf4gss4g1DoaU4rXorlUDsAdRA=";
              };
            }
          );
          utreexod = default;
        };
      }
    );
}
