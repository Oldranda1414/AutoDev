

{
  description = "Scala project development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    sbt = {
      url = "github:scalac/sbt-nix";
      flake = true;
    };
    scala = {
      url = "github:scalac/scala";
      flake = true;
    };
    java17 = {
      url = "github:jdkalliance/openjdk17";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, sbt, scala, java17 } @ {
    devShell = {
      nativeBuildInputs = [ java17 ];
      buildInputs = [
        (sbt.packages."org.scala-sbt"."sbt"._2_1_0)
        (scala.packages."2.13"."scala-compiler")
        (scala.packages."2.13"."scala-library")
      ];
      shellHook = ''
        export PATH=$PATH:${sbt}/bin
        export PATH=$PATH:${scala}/bin
      '';
    };

    default = self.devShell;
  };
}