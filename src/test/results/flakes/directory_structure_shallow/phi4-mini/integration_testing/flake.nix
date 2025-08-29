nix
{
  input = builtins.currentPlatform;

  let

    nixpkgs = inputs.nixpkgs;

    # Define your development environment here.
    developEnv = imports: prev {
      devShell = import { config, pkgs, ... } < (import inputs. >;
        stdenv               = "nix$(inputs.dev ver -ge 1 ? . : input)stdenv";
        with x86_64-linux; # This should match the target platform of your development environment
      };
    };

  in

  build.nims = {
    project-repo = developEnv { mkDerivation, ... } + stdenv:
  }
}
