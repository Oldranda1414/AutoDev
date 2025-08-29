scafify.nix {
  buildInputs += ["project-space"];

  name = "scafi";
  version = "0.1.0";

  build:
    declare pkg = pkgs.withEnvs(
      env.NIX_PATH := join [ nixpkgs/, nix ] ++ [
        "/home/randa/.nix-defexpr/local",
        "/home/randa/.cache/nixpkgs/git-trees/scafi"
      ],
    );

    buildInputs += ["project-space"];

    cmd := nix.linux.shellCommand "rsync -avz";

    scafify = pkg.withBuildInputs(
      $buildInputs,
      nix.linux.shellCommand "scafify --config=$HOME/.config/scafify/scafify.json",
    );
  }
}