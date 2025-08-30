{ description = "LLM Intro"; 
buildInputs = [ java ]; 
projectRoot = .; }

{ pkgs ? import <nixpkgs> {} }:

stdenv.mkDerivation {
  name = "llm_intro";
  buildCommand = ''cd ${projectRoot} && sbt'';
}

let
  project = import ./project { };

in

project