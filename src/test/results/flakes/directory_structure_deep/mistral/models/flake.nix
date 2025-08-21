 
nix-workspace {
  pkgs = { inherit scala; };

  overrides = {
    scala.versions = "2.13";
  };

  desc = "Development environment for the models project.";

  phases = "build";

  derivations = { self, nix-preconfigured }: [
    scala-project {
      src = ./.;
      buildSystem = sbt;
      buildInputs = [
        nix-preconfigured.scala213
        scalaPackages.sbt;
        scala.macros;
      ];
    };
  ];
}
