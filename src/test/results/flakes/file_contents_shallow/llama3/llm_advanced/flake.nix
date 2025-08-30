{ 
  description = "LLM Advanced";
  inputs = {
    nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/master;
  };
  outputs = { self, nixpkgs }: let 
    pkgs = import nixpkgs {
      overlays = [ (self: final: {
        // add your overlays here
      }) ];
    };
  in 
  {
    devShell = pkgs.mkDerivation {
      name = "dev-shell";
      buildInputs = with pkgs; [
        # Add your dependencies here
        sbt
      ];
    };
  };
}