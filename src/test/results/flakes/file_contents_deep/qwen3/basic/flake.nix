

{
  description = "Julia project development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs;
    in
    {
      devShell = pkgs.buildDevShell {
        buildInputs = [ pkgs.julia ];
        shellHook = ''
          export JULIA_HOME=$HOME/.julia
          julia --project=$HOME/.julia
        '';
      };
    };
}