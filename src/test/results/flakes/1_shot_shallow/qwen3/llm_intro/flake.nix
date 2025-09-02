

{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells."${system}".default = pkgs.mkShell {
      packages = with pkgs;
        [
          ollama
          uv
          mermaid-cli
          just
          scalaPlatform.scala3_3_5
          sbt.sbt_1_10_7
        ];
    };
  };
}