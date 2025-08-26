

{
  flake = {
    description = "Java project with Gradle"
    outputs = { self, pkgs ? pkgs, ... }: {
      devShell = pkgs.stdenv.mkDerivation {
        name = "dev-shell"
        buildPhase = ''
          echo "Dev shell for Java project"
        ''
      }
    }
  }
}