{ 
  description = "Acceptance Testing";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64;
    acceptance-testing = pkgs.stdenv.mkDerivation {
      name = "acceptance-testing";
      buildInputs = [ 
        pkgs.jdk
        pkgs.sbt
      ];
      postBuild = ''
        sbt -jvm-args "-Xss1m" compile
      '';
      shellHook = ''
        source activate-sbt.sh
      '';
    };
  in {
    devShells.x86_64.acceptance-testing = acceptance-testing;
  };