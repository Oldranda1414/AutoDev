{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.followSymlinks = false;
    pkgs = { flake = null; };
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = rec {
      pkgs = import nixpkgs {
        inherit system;
      };
      env = pkgs.mkShell {
        packages = with pkgs; [
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
  };