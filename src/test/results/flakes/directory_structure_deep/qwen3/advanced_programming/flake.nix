

{
  outputs = { self, scala, sbt: {
    inherit self scala sbt;
    development = {
      nativeBuildInputs = [ sbt ];
      buildInputs = [ scala ];
      phases = ["unpackPhase" "buildPhase" "checkPhase"];
      buildPhase = "sbt compile";
      checkPhase = "sbt test";
      source = ./.;
    };
  }};
}