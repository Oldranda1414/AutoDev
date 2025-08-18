{ 
  description = "LLM Intro";

  outputs = { self, nixpkgs }: 
    let
      pkgs = import nixpkgs {};
    in
    {
      devShell = pkgs.mkshell {
        buildInputs = [ 
          pkgs.java
          pkgs.maven
          pkgs.eclipse
        ];
        shellHook = ''
          export MAVEN_OPTS=-Xmx2g -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC
          source $(dirname $0)/vagrant.sh
        '';
      };
    };

  inputs = 
    { 
      nixpkgs = builtins.fetchTarball "https://nixos.org/nix/nix-2.13.tar.gz"; 
    };