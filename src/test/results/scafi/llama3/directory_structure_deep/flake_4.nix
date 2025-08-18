{ 
  description = "Scafi Development Environment"; 
  inputs = { 
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixpkgs/nixpkgs";
      ref = "nixpkgs-unstable";
    };
    scala = builtins.fetchgit {
      url = "https://github.com/scala/scala.git";
      ref = "2.13.7";
    };
  }; 
  outputs = { self, nixpkgs, scala : 
    let
      pkgs = import nixpkgs {};
      buildInputs = [ scala ];
      devShell = pkgs.mkShellRec {
        commands = [
          { name = "sbt"; value = "${scala}/bin/sbt"; };
        ];
      };
    in 
    { 
      devShells.x86_64-linux = devShell; 
    }; 
}