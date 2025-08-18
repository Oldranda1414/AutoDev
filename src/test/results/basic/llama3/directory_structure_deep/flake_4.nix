{ description = "basic";
  inputs = {
    julia = { url = "github:julialang/julia"; flake = false; };
  };
  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64Linux;
    devShells = with pkgs; {
      julia = pkgs.mkShell({
        name = "julia";
        command = "${self.packages.${pkgs.system}.julia}/bin/julia";
      });
    };
  in
    self.datasets.toPlacebo() + { devShells = devShells; }