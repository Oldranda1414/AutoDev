

{
  description = "Development environment for Scala project";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = { self, nixpkgs ? pkgs }:
    let
      scala = pkgs.scala_2_13;
      scalaTest = pkgs.scalaTest_2_13;
      scalaJava8Compat = pkgs.scalaJava8Compat_2_13;
      scalaLibrary = pkgs.scalaLibrary_2_13;
      scalaReflect = pkgs.scalaReflect_2_13;
      scalaCompiler = pkgs.scalaCompiler_2_13;
    in
    {
      devShell = {
        name = "devShell";
        outputs = {
          devShell = {
            shellHook = ''
              # Add any shell hooks here
            '';
            packages = [
              scala
              scalaTest
              scalaJava8Compat
              scalaLibrary
              scalaReflect
              scalaCompiler
            ];
          };
        };
      };
    };
}