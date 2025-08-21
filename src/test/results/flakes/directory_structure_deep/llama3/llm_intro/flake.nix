{ 

flake = basicFlake; 

}

outputs = { self, nixpkgs }: {

devShells = pkgs.mkDerivation {
  name = "llm-intro";
  buildCommand = ''
    cd llm_intro
    yarn install --frozen-lockfile
  '';
  buildInputs = [ pkgs.yarn ];
};

override Flake = self: super: {
  devShell = self.devShells.;

};