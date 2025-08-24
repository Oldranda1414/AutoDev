nix
let
  main =
    flakeBundle "" "sbt" {
      dependencies =
        [
          {name = "scaffold"; version = "0.17.5-2023.04.22.0";},
          {name = "test-target"; version = "0.17.5-2023.04.22.0";},
        ];
      sourcePaths = ["./src"];
    };
