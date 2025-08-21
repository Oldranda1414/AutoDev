{ 
  description = "Advanced Programming";
  inputs = { nixpkgs = builtins.fetchGit https://github.com/nixos/nixpkgs; };
  outputs = { self, nixpkgs }: let pkgs = nixpkgs; in rec {
    devShells.x86_64-linux = pkgs.mkdte = pkgs.buildEnv {
      name = "dev";
      paths = [ (pkgs.vim) ];
    };
  };
}