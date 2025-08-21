nix
{
  description = "Scaffolder Nix project development environment";

  inputs = {
    nixpkgs.url = https://github.com/NixOS/nixpkgs/archive/refs/tags/v2.5.tar.xz;
    flake-utils.url = github:fliak/wrap-pkgs.nix ?ref=main;
  };

  outputs = { self, nixpkgs, flakeUtils }:
    let
      overlay = final: prev: {
        ghc = prev.lib.overrideAttrs (prev.ghc) {
          patches = [
            ./lib/patches/overlay.patch,
          ];
        };
      };
    in lib.reduceNixPkgsInputs { inherit nixpkgs; flakeUtils } (
      let
        nixpkgsWithOverlay = overlay nixpkgs;
      in {
        defaultPackage = with nixpkgsWithOverlay; stdenv.overrideToolsAttrs (env: {
          ghc = null;
        });
      }
    );

  devShells.scaffiDevShellDependencies = [
    flake-utils.libBuildPhase { builder phase inputs } ''
      cd scafi
      runEnv nix develop

      -- Assuming the build.sbt and project/build.properties are necessary for compiling Scala code.
      sbt clean compile
      
      exitSuccess
    '';
  ];
}
