{ 
  description = "Development environment for Scafi";
  inputs = {
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixos/nixpkgs";
      ref = "nixos-unstable";
    };
    scala = builtins.getbootstrap {};
  };
  outputs = { self, nixpkgs, scala }: 
  let
    projectDir = ./scafi;
    buildInputs = with scala; [ scala ];
  in 
  self.defaultPackage.${projectDir} = {
    buildInputs = buildInputs;
  };
}