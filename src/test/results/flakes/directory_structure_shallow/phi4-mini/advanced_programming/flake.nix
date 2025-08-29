nix
{
  description = "Development environment for advanced_programming project";

  inputs.nixpkgs.url = "https://github.com/nixos/nixpkgs/archive/21.05.nlinux20230409.tar.gz";
  
  outputs = { self, nixpkgs }: {
    devShellEnv = import ./default.nix;
    
    defaultPackage pinned =
      pkgs.callNixModules (self: super => {
        inherit (nixpkgs) shellPackages;
        
        packages = [ "scala" ];
        
        buildPkgs evaluationEnv : self.shellPackages.sbtBuild
          { scalaVersion = "2.11"; }
          
        dependencies = with nixpkgs; [
          bash
        ];

        pkgs.buildEnv {
          name = "dev-env";
          pathsToTarballs = [ "${self}" ];
        };
      });
  };

  configShells = self: super: {
    devShell = import ./default.nix;
  };
}


Note that you'll need a `default.nix` file in the root of your flake directory, something like this:

nix
{
  description = "Development shell";

  inputs.urlNixpkgsFlakesURL ="https://github.com/nixos/shells/flakes"
  
  outputs = { self }@ inputs: nixpkgs := import <nixpkgs> {
    inherit urlNixpkgs;
  }:

      callPackage ./default.nix {};
}


Make sure to have a `build.sbt` in your project that uses the appropriate Scala version and dependencies. The above flake setup assumes you are using Nix for managing development environments with sbt as shown.

Please ensure you're running this within an environment where these configurations make sense, i.e., there exists proper `.gitignore`, etcetera to prevent undesired state mismatches or issues due to untracked files causing errors that might be thrown on `nix flake check`. Also update your nixpkgs URL and other versions as necessary.