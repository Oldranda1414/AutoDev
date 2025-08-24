 nix
{ pkgs ? import <nixpkgs> {} }:

{ name = "example";
  src = .;
}
