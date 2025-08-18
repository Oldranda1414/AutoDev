{ 
  description = "Scafi Development Environment";
  inputs = {
    nixpkgs = builtins.fetchTarball("https://github.com/nixos/nixpkgs/archive/22.11.tar.gz");
  };
  outputs = { self, nixpkgs }: 
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      bazelBuild = pkgs.bazelBuild;
      sbtMinimal = pkgs.sbtMinimal;
    in 
    {
      devShell = pkgs.mkShell {
        buildInputs = [ bazelBuild sbtMinimal pkgs.scala ];
      };
    };
}