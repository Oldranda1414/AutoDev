{flakeName} = rec {
  description = "scafi development environment";
  inputs = {
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixos/nixpkgs";
      inherit (nixpkgs) flake.lock;
    };
  };

  outputs = { self, nixpkgs }: rec {
    overrideFlakes = final: prev: {
      scala = prev.nixpkgs.scala;
      sbt = prev.nixpkgs.sbt;
    };

    default = (import ./nix/project.nix) // overrideFlakes;
  };
}