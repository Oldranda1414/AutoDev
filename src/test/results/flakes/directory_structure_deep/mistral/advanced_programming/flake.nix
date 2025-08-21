 Here is an updated flake.nix file for your project with a cleaner structure:

nix
{ stdenv, nix-build, scala }

desc = "Advanced Programming Project"

buildInputs = [
  scalaPackages.scalaCore
];

 derivations = { pkgs ? import <nixpkgs> {} }: [
   pkgs.stdenv.mkDerivation {
     name = "advanced-programming-build";
     src = ./.;
     buildInputs = [ ${buildInputs} ];
   }
];
