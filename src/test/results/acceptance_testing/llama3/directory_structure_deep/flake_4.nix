{ 
  description = "Acceptance Testing Environment"; 
  inputs = { nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/master.tar.gz; }; 
  outputs = { self, nixpkgs }: let pkgs = nixpkgs.legacyPackages.x86_64-linux; in rec {
    devShells.x86_64-linux.acceptance-testing = pkgs.mkShell {
      name = "acceptance-testing";
      buildInputs = [ pkgs.sbto pkgs.java11 ];
      shellHook = ''
        echo "Initializing acceptance testing environment..."
        sbt
      '';
    };
  }; 
}