{ 
  description = "Development environment for Scala project";
  inputs = {
    nixpkgs = builtins.fetchTarball https://alpha.nixos.org/nix/nix-unstable.tar.gz;
  };
  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs {};
  in rec {
    devShells.default = pkgs.mkShell {
      buildInputs = [
        (import ./models/{nixpkgs,pkgs}/default.nix)
      ];
      shellHook = ''
        source /etc/profile
        export SCALA_HOME=$(realpath $(pwd)/models/src/main/scala/)
        add-Scala-classpath $SCALA_HOME/main/scala
        echo "Loaded dev shell"
      '';
    };
  };
}