

{
  flakeFormat = "2";
  description = "My Nix Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs.flakeSubpath = "pkgs";
  };
  outputs = { self, nixpkgs }@inputs: {
    defaultApp = nixpkgs.stdenv.mkDerivation {
      buildCommand = "echo hello";
    };
  };
}