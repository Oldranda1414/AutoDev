

{
  description = "Scala development environment";
  inputs = {
    scalaPlatform = {
      url = "github:numtide/scala-platform";
      flake = true;
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
      flake = true;
    };
  };
  outputs = {
    self = { config, pkgs, ... }:
      let
        scala = pkgs.callScalaAttrs scalaPlatform {
          scalaVersion = "3.4.0";
        };
      in
        pkgs.develop {
          name = "Scala development environment";
          inputs = {
            scala = scala;
            nixpkgs = pkgs;
          };
          programs.scala = {
            home = "src/main/scala";
            test = "src/test/scala";
          };
        };
}