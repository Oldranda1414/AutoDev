{ 
  description = "scafi development environment";
  inputs = {
    nixpkgs = builtins.fetchGit { 
      url = "https://github.com/nixos/nixpkgs/master"; 
      inherit (nixpkgs) lib; 
    };
  };

  outputs = { self, nixpkgs }: 

  let
    stdenv = nixpkgs.stdenv;

    scafiEnv = stdenv.mkderivation({
      name = "scafi";
      buildInputs = [
        nixpkgs.scala_2_13
        nixpkgs.sbt
      ];
      postBuild = ''
        source $stdenv/setup
        sbt --project root
      '';
    });

  in

  self.defaultPackage.x86_64-linux = scafiEnv;