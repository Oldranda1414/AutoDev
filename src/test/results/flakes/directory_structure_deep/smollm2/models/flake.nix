Here is a possible solution for your issue. It seems like you are trying to include scala libraries from different pkgs.git repositories and that's causing issues with buildDeps:

nix
build.scala_deps.flake.buildDeps = [
    flake.pkgs.scala-library,
    flake.pkgs.spark-core,
    flake.pkgs.scala-testing,
    flake.pkgs.test-unit,
];
