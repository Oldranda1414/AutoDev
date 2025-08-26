nix
funcs = {
  gradientCast -> {
    id, center, accumulation =>
      rep ((Double.PositiveInfinity, center)) {
        accumulateData => {
          mux (source) {(0.0, center)} {
            foldhoodPlus (Double.PositiveInfinity, center) {
              minByFirst nbr(accumulateAndCast [data, value]) {
                if data == floor then floor else value
              }
            }
          }
        }
      },
  };

  decay -> {
    initialValue, floor ->
      rep initialValue :
        collected => decayWith(value) where
          mux (value == floor){floor} value:
            nbr(findParent(potential)) == mid() ? potential : nil |  // find parent potential
              value > potential then potential else value;
  }
};


# Usage example
scaffold = {
  name = "scaffold";
  builder = gradientCast.decay();

  gitRepo = git {
    repo: "/home/randa/AutoDev/src/test/space/scafi";
    fetchStrategy: "auto";
    fetchRemote: "origin";

    url: "<EMAIL>:randa/scaffold.git";
    branch: "master";
  };

  gitWorkTree = gitRepo.worktree();
};


# Generate the nix expression for a simple nix flake from the `flake.nix` file
scratchDir = tempdir in {
  prefix = "./tmp-scaffold-";
  suffix = ".";
};
mk-run-command $SCRIPTSECURE --nix nix build -p "$scratchDir" --system {} "{
  builder = gradientCast.decay();

  gitRepo = git {
    repo: "/home/randa/AutoDev/src/test/space/scafi";
    fetchStrategy: "auto";
    fetchRemote: "origin";

    url: "<EMAIL>:randa/scaffold.git";
    branch: "master";
  };

  gitWorkTree = gitRepo.worktree();
}};


# Output the generated nix expression for a simple nix flake
outDir = toSchemeDirectory (withSCMSCratch scratchDir) {
  rootDir = "${scratchDir}/nix-output";
  prefix = "./tmp-scaffold-";
  suffix = ".";

  generateFlakeExpression: {
    name: "scaffold";
    builder: gradientCast.decay();

    gitRepo: git {
      repo: "/home/randa/AutoDev/src/test/space/scafi";
      fetchStrategy: "auto";
      fetchRemote: "origin";

      url: "<EMAIL>:randa/scaffold.git";
      branch: "master";
    };

    gitWorkTree: gitRepo.worktree();
  };
};


# Output the nix expression for a simple nix flake (modified to include error handling)
outDir = withSCMSCratch {
  scratchDir = tempdir in {
    prefix = "./tmp-scaffold-";
    suffix = ".";
  };

  # Error handlers are registered as follows:
  mk-run-command $SCRIPTSECURE --nix nix build -p "${scratchDir}/nix-error-handlers" --system {} "{
    builder = gradientCast.decay();

    gitRepo = git {
      repo: "/home/randa/AutoDev/src/test/space/scafi";
      fetchStrategy: "auto";
      fetchRemote: "origin";

      url: "<EMAIL>:randa/scaffold.git";
      branch: "master";
    };

    gitWorkTree = gitRepo.worktree();
  };
};


# Output the nix expression for a simple nix flake with error handling on the output directory (modified to include error handling)
outDir = mk-run-command $SCRIPTSECURE --nix nix build -p "${scratchDir}/nix-error-handlers" --system {} "{
  builder = gradientCast.decay();

  gitRepo = git {
    repo: "/home/randa/AutoDev/src/test/space/scafi";
    fetchStrategy: "auto";
    fetchRemote: "origin";

    url: "<EMAIL>:randa/scaffold.git";
    branch: "master";
  };

  gitWorkTree = gitRepo.worktree();
};
