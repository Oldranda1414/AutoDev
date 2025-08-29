{
  version = "0.1.0";

  build:
    nix-build --out-link=./bin/${c.llm_advanced} .;

    dependencies: [
      { name = "haskell-platform-nixpkgs"; },
      { name = "james-kauffman"; }
    ]
};