{ 
  description = "Advanced Programming";
  inputs = {
    nixpkgs = builtins.fetchGit {
      url = "https://github.com/nixos/nixpkgs.git";
      rev = "master";
    };
  };
  outputs = { self, nixpkgs }: 
  let 
    pkgs = nixpkgs.legacyPackages.nixpkgs;
    project = ./.;
  in 
  rec {
    dev-sha256 = pkgs.vim;
    dev = pkgs.vim;
  };