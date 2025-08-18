{ 
  description = "LLM Advanced"; 

  inputs = { 
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixos/nixpkgs";
      rev = "nixos-unstable"; 
    }; 
    scala = nixpkgs.callPackage ./scala; 
    sbt = nixpkgs.legacyPackages.linux.sbt; 

  }; 

  outputs = { self, nixpkgs, ... } @ inputs: 
  let 
    pkgs = nixpkgs.legacyPackages.linux; 
  in rec {
    devShells.default = pkgs.mkShell { 
      buildInputs = [ 
        pkgs.scala
        sbt 
      ]; 
    }; 
  };