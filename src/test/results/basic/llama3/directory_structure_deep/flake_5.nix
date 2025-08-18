{ description = "Hello World";

inputs = {
  julia-flake = { url = "github:julialang/julia-flake"; };
};

outputs = [ (pkgs.fetchFromGitHub {
  owner = "julialang";
  repo = "julia";
  rev = "v1.7.3";
}) ];

project = name: pkgs.juliaFlake.init {
  project = name;
  src = ./.;
};
system = { config, pkgs, ... }:

let
  julia = pkgs.juliaFlake.flake { };
in

{
  devShells = [ julia ];
}
flake = self;