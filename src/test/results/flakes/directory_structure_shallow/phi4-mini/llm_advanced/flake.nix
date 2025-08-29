nix
{
  description = "Development environment for llm_advanced project";

  sources.lib.optionalSha256Source {
    url = https://github.com/rndnr/nix-flakes-sbt.git master;
  };

  devShells.llm_advancedDev = nixpkgs.mkShell {
    buildInputs =
      [ sbin.sbt
      ];

    shellHook = ''
      echo "Starting development environment for llm_advanced..."
      . "$HOME/AutoDev/src/test/space/llm_advanced/.env/bin/nix develop"
    '';
  };
}
