nix
{
  description = "Advanced programming project with Scala development environment";

  inputs =
    {
      nixpkgs.url = https://github.com/nixos/nixpkgs/archive/21.10.nix;
    } // { advanced-programmingFlake = {};
        inherit (advanced-programming) sbtVersion;

        customNixpkgs = pkgs: super.customExtensions.withFeatures { enableExperimentalShellAccess = true; };

        nixpkgsConfig = {
          overlays = [ self.overlay ];
        };
      overlay = final: prev: let
        dpathHack = import ./dpath-hack.nix {};
      in {
        advanced-programmingFlake = dpathHack.dhallFiles.hello-nix.devEnv flakeNixDevEnvironment;
      }
    };

  outputs = { self, nixpkgsConfig, ... }: let
    customExtensionsSourcePath = "/custom/extensions";

    devShells.x86_64.natives.HelloNix.devEnvConfig =
      {
        packages.xplat.systemPackages += [
          python3.withPlugins [ "flake8" ]
        ];
      };

  shellHook = ''
    echo "Starting development environment for advanced-programming project..."
    nix develop
  '';

  devShells.hello-nix-devEnvironment.dhallFiles.srcDir = "/custom/extensions/hellonix/dhall-files";

  flakeNixDevEnvironment =
    import (nixpkgs) { config, pkgs } [
      ({ echo; })
      {
        packages.xplat.pythonPackages.flake8 = null;
      }
    ];

}
