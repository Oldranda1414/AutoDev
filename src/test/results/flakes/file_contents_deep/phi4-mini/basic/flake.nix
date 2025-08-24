nix
{
  description = "Development environment for a basic project";

  inputs.nixpkgs.url = "https://github.com/nixos/nixpacks/raw/main/packages/nixpkgs";
  
  outputs = { self, nixpkgs }: {
    devShell = let pkgs = import nixpkgs {
      inherit system;
    };
    
    in buildEnv {
      name = "basic-env";

      sources = [
        (fetchGit {
          url = "/home/randa/AutoDev/src/test/space/basic/.git";
          pathToContent = ".";
        })
      ];

      languagePlanImports =
        [ pkgs.julialang.withPackages ([ juliaPkgs.nj j => "nightly" ]) ];
    };
  };

  buildEnv.defaultShellHook += ''
    echo -e "\nWelcome to the basic development environment. Run 'dev' for a quick start."
    
    nix develop ./
  '';
}
