

{
  description = "Development environment for Scala project";
  inputs = {
    scala = {
      url = "github:scalac/scala-cli/0.21.0";
      flake = true;
    };
    sbt = {
      url = "github:sbt/sbt/1.7.2";
      flake = true;
    };
    java = {
      url = "github:openjdk/binaries/17.0.5";
      flake = true;
    };
    junit = {
      url = "github:junit-team/junit5/1.8.2";
      flake = true;
    };
    cucumber = {
      url = "github:cucumber/cucumber-jvm/6.10.4";
      flake = true;
    };
  };
  outputs = { self, scala, sbt, java, junit, cucumber } @ {
    devShell = {
      nativeBuildInputs = [ java.java ];
      buildInputs = [ scala.scala sbt.sbt junit.junit cucumber.cucumber ];
      shellHook = ''
        export PATH=$PATH:$HOME/.local/bin
        sbt
      '';
    };
  };
}