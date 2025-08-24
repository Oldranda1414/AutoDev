nix
{
  description = "Project development environment";

  inputs =
    let
      nixFlakePublicInputs = { pkgs, flake-utils }: (
        import (flake-utils.nix) {
          overlays = [
            ({ pkgsNixOS ? false }): []
          ];
        }
      )

      myProjectFlakes = {
        inherit pkgs;
        overrides = [ pkgsNixOS.overrideAttrs (_: with lib; { packages = [] }).setPkgs (nixFlakePublicInputs.pkgs) ];

        flake-nixos.defaultPatchedSelfUpgrade.enable = true;

        nixos-system-configurations.nixpkgsConfigurations.nixosDefault = {
          modules += [
            import ./config/nix-file/configure.nix
          ];
        };
      };

      myProjectPkgs = defn: let pkgsNixOS = (defn.overrideAttrs (_: with lib; { packages = [] }).setPkgs (pkgs)); in nixFlakePublicInputs.pkgs;

    in {
      # Nix flake lock for reproducibility
      overridesFrom = "default.nixos flakes/nix-flakes/flake.lock";

      outputs =
        let pkgsConfig = myProjectFlakes.Overrides.fromInput missings inputs;
          devShellEnv = (import ./dev-shell.nix {}).buildEnv {
            name = self.name;
            packages = [ pkgsNixOS.defaultPackage ];

            overlays = [
              import ./overlay/nix-dev-env-overlay/default.overlay
            ];
          };
        in {
          nixpkgsConfig =
            inputs.pkgs.nixosConfigurations.myProjectFlakes.Overrides.fromInput missings myProjectPkgs;

          devShellEnv = buildJSON.devShellEnv;
        }
    }

  dev-environment-name = "asmd24-01-atdd-dev";

  packages = [ pkgsNixOS.defaultPackage ];

  nixpkgsConfig.allowUnfree = true; # Allow unfree software if needed
}
