nix
{
  description = "Development environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs }:
    let systemName =
        if builtins.fetchurl (builtins.currentPlatform ? '' : 'https://nixos.org/configuration/latest') >>= fetchTarball
          then ''
            x86_64-linux
          else ''
            unsupported-platform;
      pkgs = import nixpkgs {
        inherit system name;
      };
    in {
      devShells.${systemName}.default =
        let pkgs = self.pkgs; # using 'self' to refer to the imported packages correctly
        in mkShell {
          shellHook = ''
            echo "Starting development environment with ${systemName}"
            nix develop .
          '';
          buildInputs = [ 
            ollama
            uv
            mermaid-cli
            just
          ];
        };
    };
}
