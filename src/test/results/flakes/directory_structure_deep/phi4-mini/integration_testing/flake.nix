nix
{
  description = "Project development environment using Nix and sbt";

  srcsSelf = { self, pkgs }: {
    devEnvDevShell.nixpkgsLibBuildInputs = [
      (self // packages.sbt).packages.sbt.devDependencies ++ [

        # Required for integrating with Scala projects
        scala

        # Add additional dependencies here specific to your project needs
        
      ];

      pkgs.scalaJars.packagesScalapkgExtraSbtPlugins.jvmPlatformPkgs.lib.optionalGroups = [ { dev } ] [
        slf4j-jdk8
      ]
    ];
  };

  overrides = self: superNixpkgs:
    let customTools =
      with buildutils; (self // packages.nix.shells.mkShell + pkgs.stdenv.toFile)
    in {
      inherit (
        nixpkgsSrcDevEnv.devEnvBuildInputs
      );
      libHookFlags = [
        customTools.libFlag "-A nixpkgs.version=21.11"
      ];
      extraSystemConfigurationsSelf.customNixModules = [ customTools ];

      tools = with pkgs; buildutils.pkgs;
    };

  devShellsDevEnvironment.nixosDerivationOverrides =
    {
      inherit overrides;

      defaultSystems = self: superNs:
        let nixpkgsSrcEnv = { mkPkgs ? true }: self.nixpkgsSrcOverride
          (self // packages.sbt.devDependencies);
        in [
          nixpkgsSrcEnv.defaultSystem devDepsTools,
          # Use your sbt project directory as a workspace, or add it to NIX_STORE here.
          "path": "/home/randa/AutoDev/src/test/space/integration_testing"
            ./sbt/sbin/projector --project integration-testing
        ]
    };

  flakeNixSelf = self: superNs:
    let nixpkgsSrcEnv = { mkPkgs ? true }: self.nixpkgsSrcOverride (self // packages.sbt.devDependencies);
    in {
      inherit overrides;
      
      srcsDevShellSbtPathName = "/home/randa/AutoDev/src/test/space/integration_testing";
      devEnvironmentBuildInputsNixPkgsLib =
        nixpkgsSrcEnv.defaultSystem
          ./build.nix // lib.build.sbt.devDependencies;

      defaultSystemsSelf.customNixModulesSelf = { mkPkgs ? true }: [
        import (self: superNs:
              self.//packages.gitmodulesGitModuleDevPackages) {
            inherit devEnvironmentBuildInputsNixPkgsLib;
          }
        ];
    };

  extraSystemConfigurationsExtraSbtPlugins =
    with pkgs; buildutils.pkgs;

}
