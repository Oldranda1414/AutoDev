 
{ pkgs ? import <nixpkgs> }:

stdenv.mkDerivation rec {
  name = "integration_testing";
  src = ./.;
  buildInputs = [ pkgs.java ];
}
