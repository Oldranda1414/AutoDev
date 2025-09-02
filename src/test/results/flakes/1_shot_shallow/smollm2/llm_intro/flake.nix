nix
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "https://github.com/langchain-org/langchain4j.git@main";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
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


this is the name of the file/folder: llm_intro.
these are it's contents if it is a file:
