

flake {
  description = "Scala project with sbt";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  outputs = { self, nixpkgs, scala } @ {
    devShell = nixpkgs.mkShell {
      buildInputs = [ scala.pkgs.scala_2_13 ];
      tools.sbt = nixpkgs.sbt_1_8_1;
      shellHook = ''
        sbt
      '';
    };
  };
}