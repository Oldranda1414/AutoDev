{ flake = self Flake;

inputs = {
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs";
    ref = "nixos-unstable";
  };
};

outputs = { self, nixpkgs }: rec {
  devShell = nixpkgs.mkShellRec({
    buildInputs = [
      nixpkgs.scala
      nixpkgs.sbt
    ];
    ShellHook = ''
      source $stdenv/setup
      sbt
    '';
  });
};
nix develop