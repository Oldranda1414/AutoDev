

nix
{
  description = "Development environment for acceptance_testing";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/{commit}";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { inherit system; };
      devShell = pkgs.stdenv.mkDerivation {
        name = "dev-shell";
        buildInputs = [
          pkgs.java17
          pkgs.sbt_2_13_17
        ];
        shellHook = ''
          export PATH=$PATH:$HOME/.sbt/boot/:$HOME/.local/bin
          sbt ++$pkgs.sbt_2_13_17.version
        '';
      };
    in
    {
      devShell = devShell;
      default = devShell;
    };
}
