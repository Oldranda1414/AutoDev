

{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = with pkgs;
      [
        # Scala 3.4.0
        scala340
        # SBT 1.9.7
        sbt1_9_7
        # used to run LLMs locally
        ollama
        # modern python package manager
        uv
        # cli to turn mmd files into mermaid graph pngs
        mermaid-cli
        # modern command runner
        just
      ];
    };
  };
}