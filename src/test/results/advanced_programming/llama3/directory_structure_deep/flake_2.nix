{ pkgs ? import <nixpkgs> {} }:

let
  scala = pkgs.scala;
  sbt = pkgs.sbt;

in

pkgs.mkDerivation {
  name = "advanced_programming";
  buildInputs = [ scala sbt ];
  buildCommand = ''
    mkdir -p $out/src/main/scala
    cp ${toString ./src/main/scala}/* $out/src/main/scala/
    mkdir -p $out/test/scala
    cp ${toString ./test/src/main/scala}/* $out/test/scala/
    sbt --project advanced_programming build
  '';
}