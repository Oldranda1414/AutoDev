

{
  description = "Scala project development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      scala = pkgs.scala_2_13;
      sbt = pkgs.sbt_1_8_1;
    in
    {
      devShell = pkgs.stdenv.mkDerivation {
        name = "dev-shell";
        buildInputs = [
          scala
          sbt
        ];
        shellHook = ''
          echo "Starting development environment"
        '';
      };

      packages = {
        scala = scala;
        sbt = sbt;
      };
    };

  nixpkgs = {
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs";
    };
    outputs = { self, nixpkgs }:
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        scala = pkgs.scala_2_13;
        sbt = pkgs.sbt_1_8_1;
      in
      {
        devShell = pkgs.stdenv.mkDerivation {
          name = "dev-shell";
          buildInputs = [
            scala
            sbt
          ];
          shellHook = ''
            echo "Starting development environment"
          '';
        };

        packages = {
          scala = scala;
          sbt = sbt;
        };
      };
  };
}