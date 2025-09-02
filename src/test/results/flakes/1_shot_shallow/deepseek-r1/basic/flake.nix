
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShells."${system}".default = pkgs.mkShell {
      buildInputs = [
        # Julia dependencies
        pkgs.julia5
        
        # Project-specific packages (you can uncomment and add specific Julia packages)
        # pkgs.pycall3_julia_1_0   # Example for PyCall if needed, adjust Julia version accordingly
        
        # Common development tools from example
        ${pkgs.ollama}
        ${pkgs.uv}  # Python package manager
        ${pkgs.mermaidCli}
        ${pkgs.just}
      ];
      
      nativeBuildInputs = [
        pkgs.git
      ];  # Include git for version control
      
      shellHook = ''
        echo "This is the development environment"
      '';
    };
  }
}