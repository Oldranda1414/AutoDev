nix
{
  description = "Development environment for models project";

  inputs = {
    nixpkgs.url = https://github.com/nixos/nixpacks.git;
  };

  outputs = { self, nixpkgs }: {

    devShellPathtoSrc ? "/home/randa/AutoDev/src/test/:$PWD",

    flakeEnv = import (nixpkgs.flake-utils) {
      config = defConfig.override {
        homeDir = "$HOME";
      };
    };

    defaultPackage = with nixpkgs; pkgs.stdenv.mkDerivation {

      name = "models-env";

      src = ./src;

      buildInputs = [
        flakeEnv.nixPackages.sbt
        # Add any other dependencies here, for example:
        (flakeEnv.pip3.packages."your-python-dependency").default
      ];

    };

  };
}
