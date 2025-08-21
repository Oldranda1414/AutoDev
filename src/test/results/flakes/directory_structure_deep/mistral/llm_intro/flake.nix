 nix
{ stdenv, java11, nix-prefabs }:

desc = "Development environment for llm_intro project";

buildInputs = [
  stdenv.make
  java11
];

overrides = {
  stdenv = {
    javaVersion = "11";
  };
};
