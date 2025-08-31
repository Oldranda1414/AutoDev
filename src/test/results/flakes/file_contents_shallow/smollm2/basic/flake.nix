nix
flake.nix =
  with builtins (here);
    pkgs =
      import <nixpkgs> {
        darwin := true;
      };
