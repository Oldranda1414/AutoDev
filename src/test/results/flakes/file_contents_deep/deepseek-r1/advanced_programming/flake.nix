
{
  description = "Scala development shell";

  inputs = {
    scala-unified-308 = { 
      url = "https://github.com/lampepen/nix.scala";
      rev = "v0.12.1"; # pick a version that supports Scala 3.0.0 or above
    };

    nixpkgs = {
      url = "https://nixos.tarantakis.org/";
      sha256 = "..."; # You'll need to get the actual hash from the URL, but for now we omit it because the user didn't provide one.
    };
  };

  outputs = { self, nixpkgs, scala }: rec {
    devcontainer::platforms.nixos-3.04-x86_64-linux {
      name = "scala3-shell";
      system = "x86_64-linux";

      specialisation = "duniverse"; # Or whatever you want

      dependencies = import (builtins.searchPathAdd {"nixpkgs"} { 
        inputs.nixpkgs.followsFrom = true; 
        inputs.scala-unified-308.inputs.nixpkgs.overrides = {
          scala.enableFlakes = true;
        };
      });

      devShell = callPackage (import ./scala3) {
        overrides = rec {
          nixosSystem = { system = self.system; ... };
          scala = self.scala32_13; # or whatever version you need, but we can use the unified one
        };
      };

    }

  }

}