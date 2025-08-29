

{
  description = "LLM Intro Project";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
      flake = true;
    };
  };
  outputs = { self, args @ { ... } }: {
    devShell = {
      buildInputs = [ scala_2_13 ];
      shellHook = ''
        cd ${args.workspace}
        sbt ++$${self.scala-overlay.version} compile
      '';
    };
  };
}