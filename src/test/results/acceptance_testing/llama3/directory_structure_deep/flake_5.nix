{ pkgs ? import <nixpkgs> {} }:

let
  nixpkgs = builtins.fetchTarball("https://github.com/nixos/nixpkgs-channels/nixpkgs-unstable");
in

  flake-utils.mk Flake {
    name = "acceptance-testing";
    inherit pkgs;
  }
  (args$ @ { }) -> import ./flake.lock.nix {
    # The project root.
    src = ./.;

    # The build dependencies, including the project itself.
    depsBuildDon'tFix = [ pkgs.jdk pkgs sbt ];

    # The development environment to use when running "nix develop".
    devShells = {
      default = pkgs.mkShell {
        buildInputs = [ pkgs.jdk pkgs sbt ];
      };
    };

  }