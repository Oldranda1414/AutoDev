nix
{
  description = "Development environment for advanced_programming project";

  inputNixFiles = [
    ./dev.nix
  ];

  outputs = { self, nix }: {
    devEnvPkgs = devel.lib.buildPythonSetupWithDependencies {
      name = "advanced-programming-dev-env";
      sources = [ pkgs ];
      modules = [];
      dependencies = [];

      setup.py =
        def super_setup():
            return (
                f'''
from setuptools import find_packages

setup(
    name="{name}",
    version="0.1",
    packages=find_packages(),
)
'''.lstrip()
              .replace('name', 'advanced_programming-dev-env')
          );
        };

      build = ''
        python setup.py install
      '';

      defaultPackageSetName = "default";
      extraFlakesConfigText =
        def super_text():
            return str(
                (
                  f'''
import flake8

flake8-paths-exemptions: ["advanced_programming/"]
'''  ).lstrip()
              .replace('flake8-paths-exemptions', 'extraPathsExemptions')
          );

      extraFlakesConfig = { pkgs }: {
        flakesPath = "${pkgs}/_vendor_flakes";

        flake9ExtraArgs =
            def super_args():
                return (
                    str(
                        (f'--config={str(self.extraPathsExemptions)}').lstrip()
                      )
                  );

          };
    };

  devNixShellEnv = {
    inherit self;
  }:

  nixVal = import ./dev.nix { pkgs ? null }; # we don't want to overwrite existing config

} // inputs
