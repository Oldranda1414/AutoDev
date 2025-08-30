{ pkgs ? import <nixpkgs> {} }:

let
  projectRoot = ./.;

  buildInputs = [ pkgs.openjdk ];

  src = projectRoot;

in

stdenv.mkDerivation {
  name = "acceptance-testing";

  buildCommand = ''
    cp -r ${src}/project/project/build.properties .
    cp -r ${src}/project/plugins.sbt .
    sbt
  '';
}
lazyHome = ./.;
name = "acceptance-testing";
buildInputs = [ pkgs.openjdk ];
}