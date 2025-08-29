 nix
{ pkgs, ... }:

stdenv.mkDerivation rec {
  name = "scafi";
  src = .;
  buildInputs = [ pkgs.cmake ];

  configurePhase = """
    mkdir -p build && cd build && cmake ..
  """;

  buildPhase = """
    ninja
  """;
}
