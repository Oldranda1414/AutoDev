

{
  description = "Scala project development environment";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs";
      flake = true;
    };
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      scala = pkgs.scala_3_4;
    in
    {
      devShells."x86_64-linux".default = pkgs.mkShell {
        buildInputs = with pkgs; [
          scala
          scalaCheck
          scalaTest
        ];

        shellHook = ''
          cd $HOME/src/models
          sbt test
        '';
      };
    };
}