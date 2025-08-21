{ 
  inputs = { self, nixpkgs }: 
  outputs = { self, nixpkgs }: 

  let 
    stdenv = nixpkgs.stdenv; 
    javaRuntime = nixpkgs.openjdk11; 
    jdk = javaRuntime.jdk; 
    sbt = (nixpkgs.sbt_1_9_8).override { 
      buildInputs = [ jdk ]; 
    }; 

  in 
  rec { 
    devShell = stdenv.mkDerivation { 
      name = "acceptance-testing"; 
      buildInputs = [ javaRuntime sbt ]; 
      shellHook = '' 
        source $stdenv/setup
        export SBT_OPTS="-jvmargs -Xmx1024m"
      ''; 
    }; 
  };