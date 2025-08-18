

{
  description = "Scala project development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs:release-23.11";
    scala.url = "github:scalac/scala";
  };

  outputs = { self, nixpkgs, scala } @ {
    devShell = nixpkgs.legacyPackages.x86_64-linux.scala.override {
      scalaVersion = "3.2.3";
      javaVersion = "17";
      jvmOptions = { "-Xmx2G" };
    };
  };
}