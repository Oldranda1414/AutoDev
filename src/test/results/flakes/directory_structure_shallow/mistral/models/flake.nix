 Here's an updated version of your `flake.nix` file that should resolve the errors:

nix
nix = import <nixpkgs> {}
{ stdenv, nix-prefabs, scala } = nix.callPackage ../default.nix

overrideAttributes = {
  stdenv.libraryPaths = [./project];
};
