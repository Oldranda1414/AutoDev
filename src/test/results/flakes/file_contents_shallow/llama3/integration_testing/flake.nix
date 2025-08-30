flake.nix:

{
  description = "asmd-testing";

  inputs = {
    self,
    nixpkgs = builtins.fetchTarball "https://github.com/nixos/nixpkgs.git";
  };

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64;
  in {
    inherit (nixpkgs) flakeUtils;

    packages = pkgs.stdenv.mkDerivation {
      name = "asmd-testing";

      builder = ''
        ${pkgs.python3}/bin/python -m pytest
      '';
    };
  };