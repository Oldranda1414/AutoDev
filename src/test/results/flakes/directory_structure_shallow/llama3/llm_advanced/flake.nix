{ 
  description = "LLM Advanced";
  inputs = { nixpkgs = builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs";
    inherit (nixpkgs) sha256;
  }; };
  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux = nixpkgs.mk shellsCommon
      (nixpkgs.stdenvNoJJ{
        name="llm-advanced";
        packages = p: [ p ]; // Add your dependencies here

        buildInputs = [
          nixpkgs.python3
          # Add your build inputs here
        ];

        shellHook = ''
          source ${self.devShells.x86_64-linux}/bin/activate
        '';
      });
  };
}