{ description = "models"; 
  inputs = {
    nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/23.05.tar.gz;
  };
  outputs [_] = let
    pkgs = import <nixpkgs> {};
    devShell = pkgs.mkShell {
      name = "models";
      buildInputs = [
        pkgs.scala
        pkgs.sbtoverride
        pkgs.sbt
      ];
    };
  in {
    devShells.x86_64-linux = devShell;
  };