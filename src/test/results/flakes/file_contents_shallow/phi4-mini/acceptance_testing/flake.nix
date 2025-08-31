nix
{
  inputs = { nixpkgs, flake8 }:

  outputs = let
    self = builtins.currentSystem
  in {
    inherit (nixpkgs) classicPaths stdenv pkgs;

    projectDir = ./acceptance_testing/

    projects = with runCommand "test-classes" (arg @ { }) [ "-c", currentDirectory ] $:. build;
  }

  defaultPackage = name: config
    let conf = builtins.currentSystem.configuration.config / self.projectDir
      + "/target/configure"
    in hasKconfig ? if not conf then false else true
}
