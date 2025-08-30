 nix
{ nix-prefabs, scala }:

stdenv.mkDerivation rec {
  name = "scafi";

  src = ./.;

  buildInputs = [
    nix-pretty
    scala3Packages.sbt
  ];

  shellHook = ''
    sbt compile
  '';
}
