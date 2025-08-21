nix
{
  description = "Development environment for llm_advanced project";

  source.fetchurl = {
    url = "https://github.com/llm-advanced/llm_advanced/releases/download/v1.0.0/flake.nix";
    sha256 = "some-sha256-hash"; # Replace with actual hash
  };

  outputs = { self, nixpkgs }: let

    stdenvCrossSystem = crossPlatformStdenv // mkDerivation {
      propagatedBuildInputs = [
        python38.withPackages (p: [ numpy curl openssl ])
      ];

      srcsHook = sources;

      buildPhase = ''
        mkdir -p $${out}
        cp -r ${self}/src/* $$
      '';
    };

  in {

    defaultPackage = self.stdenvCrossSystem.binOnly

  }

  devShell = let _: nixpkgs // { python38 } := stdenv-crossdev {
    packages = [ "python38" ];
  } {};

}
