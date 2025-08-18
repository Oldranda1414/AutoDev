{ pkgs ? import <nixpkgs> }:

let
  java = pkgs.openjdk;
  sbt = pkgs.sbt;
in

rec {
  devShell = pkgs.mkShell {
    buildInputs = [
      sbt
      javaPackages.jdk
    ];
    shellHook = ''
      export CLASSPATH=.:${java}/lib
      ${sbt}/bin/sbt
    '';
  };
}