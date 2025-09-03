 Here is the updated flake.nix file for your project:


{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  stdenv = {
    inherit git;
  };

  outputs = self: {
    devShells."${stdenv.system}" = let
      pkgs = import stdenv.nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
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
}
