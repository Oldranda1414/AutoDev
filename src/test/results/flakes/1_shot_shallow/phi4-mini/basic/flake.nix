nix
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self , nixpkgs }: let
    system = pkgs.lib.specsystem.systemName;
  in {
    devShells."${system}".default = lib.mkShell {
      buildInputs = with pkgs; [
        bash,
        curl,
        # used to run LLMs locally (replace 'ollama' if using a different tool)
        ollama
        uv,         # modern python package manager
        mermaid-cli,# cli to turn mmd files into mermaid graph pngs
        just           # modern command runner
      ];
    };
  };
}
