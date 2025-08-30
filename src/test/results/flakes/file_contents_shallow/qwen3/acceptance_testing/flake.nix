

let
  pkgs = import nixpkgs { inherit system; };
in
{
  description = "Development environment for acceptance_testing";
  outputs = {
    self: { pkgs: { ... } } // pkgs;
    devShell = pkgs.mkShell {
      buildInputs = with pkgs; [
        scala_2_12
        sbt_1_9_8
      ];
      shellHook = ''
        cd ${pkgs.cwd}
        sbt test
      '';
    };
  };
}