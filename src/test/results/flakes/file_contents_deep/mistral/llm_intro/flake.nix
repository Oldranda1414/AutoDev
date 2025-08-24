 Here is your updated `flake.nix` file:

nix
{ stdenv, nix-profile } = import <nixpkgs> {};

inlined-nixpkgs = {
  url = "file://${nix-profile}/result/x86_64-linux/nixpkgs-<nixpkgsVersion>";
  sha256 = "0z3f89lqc96i71k7h8p1vkj9g0mliyjb6b77nkmr18c4jqd7";
};
