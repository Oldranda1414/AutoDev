 Here is the updated flake.nix file for your Scala project:

nix
{ stdenv, nix-build, scala }:

description = "Scala Project"

src = gitaddr:x-pkgs-scala/scalaproject

buildInputs = [ scala-package ]

overrides = self: super:
  inherit = [ (stdenv.mkStandard) ];
