{ 
  description = "LLM Advanced"; 
  inputs = { 
    pkgs = import <nixpkgs> {}; 
  }; 

  outputs = { 
    self: 
      let 
        java = pkgs.openjdk11; 
      in 
      rec {
        defaultPackage.x86_64-linux = java; 
      }; 
  };