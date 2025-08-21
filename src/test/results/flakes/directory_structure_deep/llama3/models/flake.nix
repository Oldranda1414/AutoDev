{ description = "models";
  inputs = {
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixos/nixpkgs.git";
      rev = "22a3f4b44c8e6d7e9e2e1a5b94f1dd4a0acce88f";
    };
  };

  outputs = { self, nixpkgs : 
    let
      scalaVersion = "3.2.102";
      sbtVersion = "1.4.9";

      buildInputs = [
        nixpkgs.scala $scalaVersion
        nixpkgs.sbt $sbtVersion
      ];

      src = ./.;

    in

    self.wrap {
      name = "models";
      builder = nixpkgs.stdenv.mkDerivation {
        name = "models-env";
        buildInputs = buildInputs;
        src = src;
      };
    };
  };