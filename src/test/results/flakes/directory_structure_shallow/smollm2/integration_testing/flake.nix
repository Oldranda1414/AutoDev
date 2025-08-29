nix
# flake.nix
import nixpkgs;

nixPackages =
  with buildKits.git;
  inherit git url https://github.com/${nix-glue:gf}labs/space-integration-testing.git;

  [ git checkout v$(nix show -p integ | grep branch | cut -d ':' -f 2) $url ]
  
in
  {
    name = "integ";
    version = builtins.versionOf $(nix show -p integ);
    description = "Integration testing tools for space.";
    licenses = [
      "Apache-2.0"
    ];
    dependencies = [
      git(git config --get path.config || ":") |> {
        url = $url;
        rev = git rev-parse HEAD;
        branches = git branch -r --list v$(nix show -p integ | grep branch | cut -d ':' -f 2);
      }
    ];
  }
