 Here is the flake.nix file you requested:

```nix
{ stdenv , fetchFromGitHub , python3.packages , mermaid , just }:

description = "Dev environment for AutoDev project"

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
}

outputs = self: with self, inputs.nixpkgs, {
  ollama = python3.packages.callPackage ./ollama;
  uv = python3.packages.callPackage ./uv;
  mermaid-cli = mermaid.callPackage ./mermaid-cli;
  just = python3.packages.callPackage ./just;

  devShells."x86_64-linux".default = stdenv.mkShell {
    name = "dev-shell";
    buildInputs = [ ollama uv mermaid-cli just ];
  };
};
```