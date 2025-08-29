{ 
  description = "Advanced Programming"; 
  inputs = { 
    scala = builtins.fetchurl { 
      url = "https://github.com/scala/scala/archive/v2.13.6.tar.gz";
    };
  }; 

  outputs = { self, nixpkgs }: let 
    pkgs = import nixpkgs {};
    project = import ./project/build.nix;
    in {
      devShell = pkgs.mkShell {
        buildInputs = [ (import ./project/build.nix) ];
        shellHook = ''
          export SCALA_HOME=$(pwd)
        '';
      };
  };