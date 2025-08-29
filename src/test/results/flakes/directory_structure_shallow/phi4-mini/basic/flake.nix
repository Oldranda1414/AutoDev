nix
{
  description = "A simple Nix flake that defines a development environment for Julia projects",

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils/master";
  },

  outputs = { self, nixpkgs, flake-utils }: 
  let
    pkgs compacts reproducible-julia =
      nixpkgs.lib.compose ({ inherit (nixpkgs) unstable; })
        // Here you can specify any additional dependencies and configurations for Julia.
  in {
  
    devShell = pkgs.mkShell {
      buildInputs = [pkgs.compact.reproducible_julia];
      
      shellHook = ''
        echo "Starting development environment with nix develop..."
        cd $NIX_ENV
        nix develop ./
      '';
    };
    
  }
}
