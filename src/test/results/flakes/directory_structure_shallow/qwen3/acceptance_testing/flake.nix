

{
  inputs = {
    scala-2.12 = callPackage { url = "github:scalac/scala"; };
    scala-2.13 = callPackage { url = "github:scalac/scala"; };
  };

  outputs = { self, scala-2.12, scala-2.13 } @ {
    devShell = callCabalShell {
      shell = {
        buildInputs = [ scala-2.12.scala-compiler ];
        nativeBuildInputs = [ scala-2.12.scala-compiler ];
        phases = [ "unpack" "build" ];
        buildPhase = ''
          cd acceptance_testing
          sbt ++$scala-2.12.version clean test
        '';
      };
    };
  };
}