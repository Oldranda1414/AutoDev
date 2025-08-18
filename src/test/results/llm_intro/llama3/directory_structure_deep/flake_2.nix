{ pkgs ? import <nixpkgs> {} }:

let
  llmIntro = pkgs.callPackage ./.

in
llmIntro.drv
{
  src = ./.;

  # Development environment
  devShell = pkgs.mkDerivation {
    name = "llm_intro-dev";
    buildInputs = with pkgs; [ scala sbt ];
    shellHook = ''
      source $out/activate
    '';
  };
}

buildInputs = [ jdk ];