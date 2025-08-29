nix
let
  pkgs = import <nixpkgs> {};
in {
  name = "llm_intro";
  deps = [
    pkgs.nixpkgs,
    "space:autodev",
    "space:autodev/llm-intro",
    "space:autodev/test-runner"
  ];
  main = exec nix-build --no-out-link --args $nixpkgs.src.fetch git:git+https://github.com/randia/llm-intro
}
