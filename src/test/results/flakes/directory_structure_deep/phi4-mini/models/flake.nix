nix
{
  description = "Development environment for a Haskell and Nix based project";

  sources =
    {
      github.com/randa/AutoDevOrg/autodev-srcNightly = { rev = "<latest_release_hash>"; url = "https://github.com/randa/AutoDevOrgs/archive/nightly.tar.gz"; };
    };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs {
        config = pkgConfig.configSelf;
      };

      scalaNixEnv =
        (import <nixos-unstable> {}).stdenv.mkDerivation {
          name = "scala-nix-env";
          src = ./.app-root/src/autodev-srcNightly/;

          nativeBuildInputs = [
            pkgs.haskellPackages.cabal2distcheck
          ];

          buildPhase = ''
            runHook preMain;
            cabalV2Check $CWD/app-root/src/autodev-srcNightly/hack/cabale/check.sh app/root/main.hs && exit 0 || exit 1;
            echo "Building scala-nix-env successfully";
          '';

          installPhase = ''
            mkdir -p /app/scala-dev
            cp ./.app-root/src/autodev-srcNightly/hack/nix/samples/x86_64-home-directory-cabale-2.3.x.y.z/bin/build-sample.sh $HOME/app/scala-dev/cabal-build-script;
            chmod +x $CWD/app-root/src/autodev-srcNightly/hack/nix/samples/x86_64-home-directory-cabale-2.3.x.y.z/bin/build-sample.sh;

            cp ./.app-root/src/autodev-srcNightly/hack/nix/samples/x86_64-home-directory-haskell-stdenv-linux-x86_64-8.10.1.darwin32.tar.gz $HOME/app/scala-dev/cabal-build-script;
          '';

        };
    in
  flake.nixosEnv = {
    devShells.x86_64.haskellPackages.cabal2distcheck.packagePath = [ pkgs.scala-nix-env ];
  };

  nixpkgs.fmtSourceForNixFlakes.enableExtension "nix-command-extras";
}
