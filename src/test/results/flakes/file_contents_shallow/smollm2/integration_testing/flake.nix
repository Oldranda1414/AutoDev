nix
{
  pkgs := import <nixpkgs/github.com> {};
  paths = with pkgs;
    [ target deps ];
}


Alternatively:

nix
{
  pkgs := import <nixpkgs/github.com> {};
  paths = {
    target = pkgs.org.apache.sbt.testing.target.scala-2.12.jar;
    deps  = pkgs.org.mockito:3+;
  };
}
