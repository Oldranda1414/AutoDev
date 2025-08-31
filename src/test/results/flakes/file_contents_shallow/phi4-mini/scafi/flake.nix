nix
{
  description = "Development environment for scafi project";

  inputs =
    {
      nixpkgs.url = https://github.com/nixos/nix.git;
    }

  outputs = { self, nixpkgs }: {

    devShellHome = import ./dev-shell.nix;

    scalaNvmEnv = pkgs.mkCrossPlatformProgram "./scala-nix/shell.sh";

    # Assuming the package 'scaffi' is available in Nix packages repository.
    scafiDevEnvs = with inputs.nixpkgs; [
      (import { nixpkgs } { buildDefaultPackages ? false }: {
        inherits (with nixpkgs; stdenv) {}; })

      pkgs.sbt
      scala

      # Assuming sbt is available in the Nix packages.
      # You need to pin down a specific version of pipenv if you use it for managing Python dependencies, or remove this line altogether and handle your environment directly with nixpkgs/shell.sh/pipenv.nix (if needed).
      @self.scalaNvmEnv
    ];

  };

}

# Assuming sbt is available in the Nix packages.
(nix develop)
