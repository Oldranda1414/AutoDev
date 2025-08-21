

{
  flake = {
    description = "Development environment for scafi project";
    inputs = {
      scala = {
        url = "github:scalac/scala";
        flakeAttrs = { inherit version; };
      };
      sbt = {
        url = "github:sbt/sbt";
        flakeAttrs = { inherit version; };
      };
    };
    outputs = {
      self, scala, sbt:
      let
        pkgs = import <nixpkgs> { inherit system; };
        scalaPackage = scala.pkgs;
        sbtPackage = sbt.pkgs;
      in
      {
        default = {
          packages = {
            scala = scalaPackage;
            sbt = sbtPackage;
          };
        };
        devShell = pkgs.mkDevShell {
          packages = with pkgs; [
            scala
            sbt
          ];
          shellHook = ''
            export PATH="${sbtPackage}/bin:${scalaPackage}/bin:$PATH"
          '';
        };
      };
    };
  };
}