
json
{
  "description": "Dev environment for AutoDev project",

  "inputs": {
    "nixpkgs.url": "github:nixos/nixpkgs/nixos-25.05"
  },

  "outputs": { 
    "self", "nixpkgs": let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in rec {
      "devShells": {
        "${system}".default: rec {
          name = "sbt-scala-shell";
          buildInputs = [
            # Java Development Kit required by Scala and sbt
            pkgs.jdkLatest
            
            # Build tool for Scala projects
            pkgs.sbt_7_xx

            # Additional development tools
            pkgs.ollama
            pkgs.uv
            pkgs.mermaidCli
          ];

          # Set SBT version based on project requirements (adjust the version if needed)
          sbtVersion = "7.x";  # Update this to your specific required version

          # Custom environment configuration for Scala projects
          nativeBuildInputs = [ pkgs.coreutils makeWrapper ];
          
          # Configuration script to set up environment properly
          phases = [
            preBuild: ''
          ];

          # Setup SBT and Java home path (adjust paths if necessary)
          shellHook = '' 
            export PATH=\`dirname \`which sbt_7_xx\`:\`PATH\`\"
            mkdir -p ~/.config/
            echo \"global/compiler ${system}:${pkgs.scala_3_x1.x.version}\"\ >~/.config/sbt/jvm.conf
            '';
        }
      }
    },
      
      "default.nix": (self: self)
    }
  }
    }
