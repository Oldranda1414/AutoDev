 nix
{ stdenv, java11Packages, sbt }:

derivation {
  name = "integration_testing";
  src = ./.;

  buildInputs = [ sbt ];

  Java-libraries = java11Packages.javaLibrary {
    name = "adoptium11";
  }

  # Assuming the SBT build uses build.sbt in the root directory and project/build.properties for common settings.
  sbtBuildPhase = "" \
    nix-build -f project/build.properties && \
    nix-build \
      --arg 'sbtArgs="--no-jline"' \
      --arg 'mainClass="your.main.class"' \
      .#project \
        ./project/plugins.sbt \
        -- -b src/test/space/integration_testing/build.sbt;
}
