{ flake = super.flake:
  outputs = {
    devShell = pkgs.callPackage ./shell;
  };
}

pkgs = import <nixpkgs> {};

sbtoverride = import ./build.sbt;

shell = pkgs.mkShell {
  buildInputs = [ sbtoverride ];
};