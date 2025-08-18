{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  buildSbt = pkgs.callPackage ./build.sbt {};
in

stdenv.mkDerivation {
  name = "llm-advanced-dev";
  buildCommand = ''
    cp -r ${./} .
    ${buildSbt}/bin/sbt
  '';
}