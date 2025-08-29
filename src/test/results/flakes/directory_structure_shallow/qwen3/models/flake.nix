

{
  description = "Scala project with SBT";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    scala = {
      url = "github:scalac/scala";
      flake = true;
      inputs = {
        nixpkgs = "github:nixos/nixpkgs";
      };
    };
  };

  outputs = {
    self: { home = {
      devShell = {
        buildCommand = "sbt";
        shellHook = "sbt";
        nativeBuild = "sbt";
      };
    };
  };
}