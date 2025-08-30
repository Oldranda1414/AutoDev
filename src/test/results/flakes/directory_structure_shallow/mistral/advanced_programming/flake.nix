 nix
{ stdenv, scala }:

stdenv.mkDerivation rec {
  name = "advanced_programming";

  src = ./.;

  buildInputs = [ scala ];
}
