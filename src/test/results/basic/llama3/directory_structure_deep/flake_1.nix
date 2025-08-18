{ 
  description = "Julia development environment"; 

  inputs = { 
    julia = {
      url = "https://github.com/JuliaLang/julia.git";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, julia →
    let 
      pkgs = import nixpkgs {};
      juliaEnv = pkgs.vimUtils.buildEnv {
        name = "julia-env";
        pathsPrepend = [ julia ];
        propagatedBuildInputs = [ julia ];
      };
    in 
      { devShell = juliaEnv.env; }
  };