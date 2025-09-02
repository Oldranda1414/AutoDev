nix
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
      buildInputs = with pkgs; [
        # used to run LLMs locally
        ollama,
        uv, # moved here so it's not unexpected by Nix Flakes parser
        mermaid-cli,
        just
      ];
    };
  };
}
