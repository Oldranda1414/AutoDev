

{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
      flakeSubstitutes = false;
    };
  };

  outputs = { self, nixpkgs, ... }: {
    "x86_64-linux" = {
      devShell = {
        buildInputs = [ nixpkgs.julia ];
        shellHook = ''
          julia --project=. hello.jl
        '';
      };
    };
  };
}