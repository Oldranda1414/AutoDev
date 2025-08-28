 
{ pkgs ? import <nixpkgs> {} }:

stdenv.mkDerivation rec {
  name = "llm_intro";
  src = ./.;
  buildInputs = [ pkgs.python ];
}
