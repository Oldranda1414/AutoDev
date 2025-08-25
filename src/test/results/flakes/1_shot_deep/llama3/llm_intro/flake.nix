{ flake = super.flake({
  name = "llm_intro";
  version = "0.0.1";

  inputs = {
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixos/nixpkgs.git";
      rev = "5b7c4d6e53efc7f2d93a5c4a3eb9e2af8ca85da6"; // this is the revision at which nixpkgs works with my code
    };
  };

  outputs = { self, pkgs }:

    let
      claim = pkgs.stdenv.mkDerivation {
        name = "claim";
        builder = ./builder.sh;
      };
    in

    pkgs.stdenv.mkDerivation {
      inherit name version;

      builder = ./builder.sh;
      src = ./.;

      buildInputs = [ claim ];

      configurePhase = ''
        echo "Hello from the configure phase!"
      '';
      buildPhase = ''
        echo "Hello from the build phase!"
      '';
    };
});