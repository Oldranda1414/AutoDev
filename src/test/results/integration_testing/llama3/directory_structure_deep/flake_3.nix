{ 
  description = "Integration Testing";
  inputs =
    { self, nixpkgs }:
      let
        pkgs = nixpkgs.legacyPackages.nixUnstable;
      in
      rec {
        devShells.default = pkgs.mkShell {
          name = "dev-shell";
          buildInputs = [ 
            pkgs.maven
            pkgs.java
            pkgs.junit
          ];
        };
      };
}