{ flake = recursiveExample: {
  inputs = self: super: {};
  outputs = self: rec {
    dev-sha256 = self.buildDerivation (attrs: rec {
      name = "advanced-programming-dev";
      buildInputs = [ self.nixpkgs.scala ];
      builder = "/usr/bin/bash";
      args = [ "-e" "-o pipefail" "-c" "${self.nixpkgs.scala}/bin/scalac main/ScalaFiles/Main.scala" ];
    });
  };
};