

{
  flake = {
    description = "Scala project development environment";
    inputs = {
      scala = {
        url = "github:scalac/scala";
        flakeAttrs = { name, version };
        name = "scala-${version}";
      };
      sbt = {
        url = "github:sbt/sbt";
        flakeAttrs = { name, version };
        name = "sbt-${version}";
      };
      java = {
        url = "github:jdk:openjdk-17";
      };
    };
    outputs = {
      self = { pkgs, scala, sbt, java }@attrs:
        let
          scalaLib = pkgs.scalaLib.override {
            scalaVersion = scala.version;
          };
          sbtEnv = sbt.sbtEnv.override {
            extraTools = [ java.java ];
          };
        in
          {
            devShell = pkgs.runCommand "dev-shell" { buildInputs = [ scalaLib sbtEnv ]; } ''
              nix develop
            '';
          };
    };
  };
}