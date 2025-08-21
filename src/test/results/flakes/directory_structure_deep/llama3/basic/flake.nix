{ description = "basic";
inputs = { julia = { url = "github:julialang/julia/refs/tags/v1.7.2" }; };
outputs = { self: let j = self.inputs.julia.flake; in {
  devShells = {
    default = self.nixpkgs.mkShell {
      buildInputs = [ j ];
      shellHook = ''
        source $j/bin/environment.jl
      '';
    };
  };
}; }