nix
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux"; # directly assign the value to 'system'
  in {
    devShells."${system}".default = mkShell {
      buildInputs = with pkgs; [
        ollama,
        uv,
        mermaid-cli,
        just
      ];
    };
  };
}
