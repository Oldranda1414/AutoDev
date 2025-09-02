

{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    scala_3_3_3 = pkgs.scala3_3_3;
    sbt_1_9_9 = pkgs.sbt_1_9_9;
  in {
    devShells."${system}".default = pkgs.mkShell {
      packages = with pkgs;
        [
          # Scala 3.3.3
          scala_3_3_3
          # SBT 1.9.9
          sbt_1_9_9
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