

outputs = { self, nixpkgs, scala }: {
  devShell = (import nixpkgs {
    inherit nixpkgs;
    overlays = [ (self: super: {
      package = super.scala.overrideAttrs (_: {
        buildInputs = [ super.scala-native ];
      });
    }) ];
  }).scala.override { buildFlags = ["-Xsource:3"]; }
}