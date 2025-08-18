{ 
  description = "Advanced Programming";
  inputs = {
    nixpkgs = builtins.fetchTarball "https://nixos.org/nix/nix-2.7.1.tar.gz";
  };
  outputs = { self, nixpkgs }: 
  let
    scala = nixpkgs.scala;
    sbt = nixpkgs.sbt;
  in
  {
    devShell = nixpkgs.mkShell({
      buildInputs = [scala sbt];
    });
  };
}