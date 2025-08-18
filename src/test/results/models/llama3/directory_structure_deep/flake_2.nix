{ pkgs ? import <nixpkgs> {} }:

let
  scala = pkgs.scala;
in

{
  meta = {
    description = "Development environment for models";
  };
  outputs = { self, nixpkgs : let
      pkgs = nixpkgs.legacyPackages.nixpkgs;
      scalaTest = pkgsscala.test;
      scalax = pkgs.scala.withJdk (jdk: {
        modules = [ jdk.name "java.desktop" ];
      });
  in
    {
      devShells.default = scalax.env;
      devShell = self.devShells.default;
    };
}