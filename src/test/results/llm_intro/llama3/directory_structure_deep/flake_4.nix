{ 
  description = "LLM Introduction"; 
  outputs = [ "devShell" ]; 
  devShell = self: 
    pkgs: 
      pkgs.mkshell ({ mkDerivation }) -> 
        let 
          nixpkgs = fetchTarball("https://github.com/nixos/nixpkgs/releases/download/22.11/nixpkgs-22.11.tar.gz");
        in 
        import (nixpkgs.path) {
          overlays = [ self.overlay ];
        };
};