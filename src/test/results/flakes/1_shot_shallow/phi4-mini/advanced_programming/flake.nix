nix
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in mkDerivation {
      name = "dev-env-${self}";
      src = ./.;

      outputs = { self, buildPhase }: if [ "${buildPhase}" == "test" ] then [
        # used to run LLMs locally
        ollama,
        # modern python package manager
        uv v1.35.0,
        # cli to turn mmd files into mermaid graph pngs
        mermaid-cli,
        # modern command runner
        just,

      ];
    };
  };

}
