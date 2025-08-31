nix
{
  description = "Development environment for llm_advanced project";

  inputs =
    {
      nixpkgs.url = https://github.com/NixOS/nix.git;
      nixFlake-ci.lib.nixosCompatGitRev ?= "[specific-revision]";
    }

  outputs = { self, nixpkgsRef, ... }:
    let
      pkgs = nixpkgsRef.pkgs;

      myEnvDependencies = with pkgs; [
        scalaJdk8j
        javaLatestVersion
      ];
    in {
      devShellDefaults = pkgs.mkShell rec {
        buildFlags = [ "--sysroot=${lib.makeQualified(pkgs.stdenv.hostSystem).path}/usr" "-no-patching -build-type=ReleaseOnly" ];

        shellHook = ''
          echo "Preparing development environment..."
          mkdir -p ${self}.output/bin
          cp lib/ /home/randa/.local/share/nix-compile-cache/
          source {env:pkgs.nixosEnv}/nix-shell --run 'echo "Environment ready!"'
        '';
      };
    };

  devShells = {
    myDevEnv = import ./dev-environment.nix;
  };
}
