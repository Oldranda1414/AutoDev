 
{
  description = "Dev environment for advanced_programming project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  derivations = { pkgs ? import <nixpkgs> {} }: {
    advanced_programmingDevShell = stdenv.mkDerivation rec {
      self, nixpkgs
      system = "x86_64-linux";

      buildInputs = [
        ollama
        uv
        mermaid-cli
        just
        scala
        sbt
      ];
    };
  }

  shellHook = ""
    nix develop --features="advanced_programmingDevShell"
  ;";
}
