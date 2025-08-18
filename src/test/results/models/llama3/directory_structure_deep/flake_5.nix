{ 
  inputs = { 
    self, nixpkgs ? import <nixpkgs> {}
  };

  outputs = { self, nixpkgs }:

  let
    pkgs = nixpkgs.legacyPackages.x86_64Linux;

    devShells = pkgs.mkShell {
      buildInputs = [ 
        (import ./models/build.sbt)
        pkgs.scala
        pkgs.sbtoverlays
      ];
    };

  in rec {
    inherit devShells;
  };