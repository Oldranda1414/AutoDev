{ pkgs ? import <nixpkgs> }:

let
  project = pkgs.runCommand "project" {};
  src = pkgs.runCommand "src" { };
in

stdenv.mkderivation({
  name = "scafi";
  buildInputs = [];
  buildCommand = ''
    mkdir $out
    cp -r ${project}/build.properties $out/project/
    cp -r ${src}/main/resources/{bundles,icon.png,loadingLogo.png,style,wall.jpg} $out/src/main/resources/
  '';
})