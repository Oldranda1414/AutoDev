 nix
{ config, pkgs } = import <nixpkgs> {}

{ stdenv, java, sbt } = pkgs

overrides = {
  java.version = "11";
}

desc = "Development environment for llm_advanced project";

derivations = [
  build = java-11.wrapBuildTools (
    inherit sbt;
    src = ./.;
  );
]
