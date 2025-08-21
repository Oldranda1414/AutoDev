
{
  "inputs": {
    "nixpkgs": {
      "url": "github:NixOS/nixpkgs",
      "rev": "d94a3f5c6b7e1c0c2d8e4f5a6b7c8d9e0f1a2b3c"
    }
  },
  "outputs": {
    "devShell": {
      "description": "A development shell for the Scala project.",
      "expr": let
        pkgs = import { url = "https://github.com/nixos/nixpkgs"; rev = "d94a3f5c6b7e1c0c2d8e4f5a6b7c8d9e0f1a2b3c"; };
        scala_3_1_0 = pkgs.scala.withScalaVersion("3.1.0");
      in
        pkgs.mkShell {
          name = "llm_intro";
          buildInputs = [
            # Build dependencies
            pkgs.sbt
            scala_3_1_0
          ];
          nativeBuildInputs = [];
          propagatedNativeBuildInputs = [
            # Needed to compile Java code from sbt tasks with the correct JDK version
            "${pkgs.openjdk17}/bin/javac"
            "${pkgs.openjdk17}/bin/java"
          ];
          tools = {
            "sbt" = {};
          };
          phases = ["generateInputs"];
          shellHook = ''
            cd ${builtins.currentSystem}
            sbt
          '';
        }
    }
  }
}