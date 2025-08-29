

{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
      flake = true;
    };
  };

  outputs = { self, nixpkgs }:
    let
      devShell = nixpkgs.legacyPackages.x86_64-linux.scala_2_13.ScalaCheck_1_17_0.override {
        nativeBuildInputs = [ nixpkgs.coursier ];
      };
    in
    {
      devShell = devShell;
      defaultShell = devShell;
    }
}