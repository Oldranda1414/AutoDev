{ 
  description = "Dev environment for llm_advanced project"; 

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  }; 

  outputs = { self, nixpkgs, ... }: let 
    system = "x86_64-linux"; 
  in { 
    devShells."${system}".default = let 
      pkgs = import nixpkgs { inherit system; }; 
    in pkgs.mkShell { 
      packages = with pkgs; [ 
        ollama
        uv
        mermaid-cli
        just
      ]; 
    }; 
  }; 

}