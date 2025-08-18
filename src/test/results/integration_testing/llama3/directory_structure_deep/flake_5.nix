{ 
  inputs = { };
  outputs = [ ( nixpkgs. CallPackage ./ . ) ];

  Flake {
    name = "integration_testing";
    systems = [ "x86_64-linux" ];

    shellHook = ''
      source activate
      cd integration_testing
      sbt
    '';
  };

  derivation = stdenv.mkderivation rec {
    name = "integration-testing";
    buildInputs = [ java ];

    buildCommand = '' 
      #!/bin/bash
      export CLASSPATH=.:$CLASSPATH
      java Adder
    '';
  };
}