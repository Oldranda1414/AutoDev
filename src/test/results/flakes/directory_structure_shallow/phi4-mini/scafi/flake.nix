nix
{
  description = "A flake for scafi project";

  inputs = {
    nixpkgs.url = "https://github.com/nixos/nix.git";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs: _, flake-utils }: {

    devShells.default.nestedDependencies = [ ];

    defaultPackage.x86_64-linux.devShell.buildInputs = with pkgs; [
      scala,
      sbt
    ];
    
    # Assuming the project uses Scala and SBT. Adjust accordingly.
    outputs.exposedPullTarballs.resultantFlakesDevEnvSrcDir = { flake-utils.lib.mkForce (outputs.default.packages.${nixpkgs.pkgsScala}/scala) };
  };

  devShells = {
    default.nestedDependencies = [ ];

    inherit builtins;
  };
}
