{ pkgs ? import <nixpkgs> {} }:

let
  flakeLock = import ./flake.lock.json;
in

{
  inputs = [ ];

  outputs = { self: rec {
    overlay = final: prev: {
      julia = prev.julia.override {
        packages = (prev.julia.packages).appendLocalCollection() with Package { path = ./basic; };
      };
    };

    devShell = self.overlay (final: {
      LANGUAGES = [ "julia" ];

      JULIA = final.julia.withPackages (ps: ps.julia-basic);

      shellHook = ''
        source activate.sh
      '';
    });
  }};
}