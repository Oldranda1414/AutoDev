
json
{
  "description": "Dev environment for AutoDev project",
  "inputs": {
    "nixpkgs.url": "github:nixos/nixpkgs/nixos-25.05"
  },
  "outputs": { 
    "*": self: inputs: outputs: let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
      };
    in {
      devShells."${system}".default = pkgs.mkShell {
        name = self.name + "-devshell-${system}";
        
        nativeBuildInputs = [ pkgs.git ];
        buildInputs = [];
        
        # Julia dependencies
        juliaPkgs = with pkgs; [
          "julia"
          # Could add more Julia packages here if needed, e.g.:
          #"IJulia"
          #"PyCall"
        ];

        # Set up environment variables or paths if necessary
        
        # Basic configuration for the development shell
        buildCommand = ''
          cd ${pkgs.lib.workspaceRoot}
          # Additional setup steps could go here (e.g., generating config files)
        '';
      };
    }
  },
  "meta": {}
}
