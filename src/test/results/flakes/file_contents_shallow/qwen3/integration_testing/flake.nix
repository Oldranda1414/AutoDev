

{
  version = 2;
  inputs = {
    sbt = {
      url = "https://github.com/sbt/sbt";
      branch = "1.9.8";
    };
  };
  outputs = { self, sbt }@inputs:
    let
      pkgs = import (sbt.fetchGit {
        url = "https://github.com/sbt/sbt";
        rev = "1.9.8";
      }) {};
    in
    {
      defaultPackage = pkgs.helloWorld;
    };
}