{ 
  description = "My Project"; 
  inputs = { 
    nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/unstable; 
    scala = builtins.fetchTarball https://github.com/scala/scala-tarball/releases/download/v2.13.7/scala-2.13.7.tar.gz;
  }; 

  outputs = { self, nixpkgs, scala }: let pkgs = import nixpkgs {}; 
    in { 
      devShell = pkgs.mkShell { 
        buildInputs = [ scala ];
        shellHook = ''
          alias develop="sbt 'project in file:${toString $PWD}/'"
        '';
      }; 
  };