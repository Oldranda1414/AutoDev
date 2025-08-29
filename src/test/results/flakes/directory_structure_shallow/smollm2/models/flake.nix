nix
flake.nix :=
    with buildTools;
        pkgs = currentWithDefault {
            inherit pkgs.default-libkernel nixpkgs;
        };

        mkShellIncludePackages = import <nixpkgs> { path = "scripts/mk-shell-include"; };
