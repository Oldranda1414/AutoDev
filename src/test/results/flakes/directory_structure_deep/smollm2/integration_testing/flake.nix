nix
flake.nix {
  name = "integration_testing";
  version = 3.10.2;
  libs-dev = ["scala", "scala-library"];

  src = gitRepositories/src/main/scala/;
}