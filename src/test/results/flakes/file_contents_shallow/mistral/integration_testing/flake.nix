 nix
{ flake, git } = import <nixpkgs> {};

flake {
  name = "integration_testing";
  src = pkgs.github {
    owner = "your-username"
    repo = "your-repo"
    commit = "your-commit-hash"
  };
}
