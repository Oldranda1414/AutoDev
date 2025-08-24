

{
  "inputs": {
    "nixpkgs": {
      "url": "github:nixos/nixpkgs"
    },
    "ollama": {
      "url": "github:ollama/ollama"
    },
    "java": {
      "url": "github:jdk8u/jdk8u"
    }
  },
  "outputs": { self, nixpkgs, ollama, java, ... }: {
    "devShells.default": {
      "buildCommand": "nix-shell",
      "shellHook": "echo 'Shell is ready'",
      "packages": [
        nixpkgs.java,
        java.java8,
        ollama.ollama
      ]
    }
  }
}