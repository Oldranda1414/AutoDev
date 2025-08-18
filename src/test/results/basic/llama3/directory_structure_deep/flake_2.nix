{ 
  description = "basic";
  inputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "hello-jl";
        buildInputs = [ pkgs.jdk ];
        shellHook = ''
          export JULIA_LOAD_PATH=$JULIA_LOAD_PATH:$PWD/basic
          alias jl="julia --color=yes"
        '';
      };
    };
}