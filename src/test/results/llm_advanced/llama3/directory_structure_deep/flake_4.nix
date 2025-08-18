{ 
  description = "My project"; 
  inputs = { nixpkgs = builtins.fetchgit {
    url = "https://github.com/nixos/nixpkgs";
    inherit (nixpkgs) rev;
  }; };
  outputs = { self, nixpkgs }: 
  let
    stdenv = nixpkgs.stdenv;

    llm-advanced = stdenv.mkderivationrec({
      name = "llm-advanced";

      buildInputs = [
        # Add your dependencies here.
        # For example:
        nixpkgs.maven
        nixpkgs.scala
        nixpkgs.openjdk
      ];

      src = .;

      buildCommand = ''
        cp -r $src/* .
      '';
    });
  in {
    devShells.x = llm-advanced; 
  };