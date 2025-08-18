{ 
  description = "LLM Intro"; 
  inputs = { 
    nixpkgs = builtins.fetchGit https://github.com/nixos/nixpkgs; 
  }; 

  outputs = { self, nixpkgs : 
    let 
      scalaBinary = "${nixpkgs.scala}/bin";
      javaBinary = "${nixpkgs.openjdk}/bin";
    in rec {
      devShell = nixpkgs.mkShell {
        buildInputs = [
          nixpkgs.sbt
          nixpkgs.scala
          (nixpkgs.javaRuntime.withPackages(ps: [ps.ant]))
        ];
        shellHook = ''
          ${scalaBinary}/scalac -target:jvm-1.8 -dsrc/main/ java/it/unibo/*.java
          ${javaBinary}/java -jar build.sbt
        '';
      };
    }; 
};