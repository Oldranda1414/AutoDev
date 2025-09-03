 Here's an updated flake.nix file that should address the issues mentioned:


{
  description = "Dev environment for Scafi project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = self: {
    devShells."x86_64-linux".default = let
      pkgs = import nixpkgs {};
    in pkgs.mkShell {
      name = "scafi-dev";
      buildInputs = with pkgs; [
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

  stdenv.mkDerivation rec {
    name = "scafi-build";
    inherit project/build.properties;
    buildInputs = [ nixpkgs.scala3 ];
  }
}


Please make sure to run `nix-prefetch-url <nixpkgs_url>` and `git clean -fdx` in the directory containing the flake.nix file before trying it out again.