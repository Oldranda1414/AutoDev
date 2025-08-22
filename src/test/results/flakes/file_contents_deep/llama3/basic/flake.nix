{ description = "basic";
inputs = {
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/tarball/master",
  };
};
outputs = { self, super, pkgs: let
  julia = pkgs.julia;
in {
  devShells.nix = self.copySimpleShell {
    name = "basic";
    buildInputs = [ julia ];
  };
}; }