

outputs = {
  devShell = {
    buildInputs = [ nixpkgs.openjdk ];
    shellHook = ''
      cd src/main/java/it/unibo/basics
      sbt run
    '';
  };
  defaultPackage = {
    buildInputs = [ nixpkgs.openjdk ];
    nativeBuildInputs = [ nixpkgs.stdenv.cc ];
    buildCommand = ''
      cd src/main/java/it/unibo/basics
      sbt compile
    '';
  };
};