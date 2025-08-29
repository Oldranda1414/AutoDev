nix
{
  description = "Development environment for Scala project";

  inputs =
    let
      nixpkgs = fetchurl https://github.com/nixos/nixpkgs/archive/v2.6.x.tar.gz#rev=1234567890abcdef;
    in {
      self.defaultPackageSet = import nixpkgs { config = builtins.ccall("fetchNixConfig", "nixString" arg1: attr, null) };
    }

  outputs =
    let
      pkgs = self.packages.${self._name}.import {};
      modelsSrcDir = ./src/test/space/models;
      scalaBuildTools = pkgs.fetchTarball {
        url = http://www.scala-lang.org/files/archive/packages/debian/binaries/scala-tools_2.13-1_all.deb
        sha256 = "sha256-hash-placeholder"
      };
    in {
      devShells =
        let _nixPkgs = import nixpkgs { config = builtins.ccall("fetchNixConfig", "nixString" arg1: attr, null) } {};
          modelsSrcDir = ./src/test/space/models;
        in mkShell (mkDerivation {
          name = "models-${model.name}-dev";
          srcs = [ model.src ];
          buildInputs = [ _nixPkgs.nuxio2_0-dev python3_dev rustc-deps ]; # Replace with actual dependencies
          shellHook = ''
            export PATH="$PATH:${scalaBuildTools}/bin"
          '';
        })
    }
}
