 Here is the updated flake.nix file based on the provided project tree:

```nix
{ stdenv, fetchFromGitHub, python3, cmake, shell }:

description = "Dev environment for AutoDev project";

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  ollama = fetchFromGitHub {
    owner = "microsoft"
    repo = "open-language-model"
    rev = "v0.16.0"
    sha256 = "sha256-xyz_ollama_sha256"; # replace with the actual sha256 checksum for the specified revision
  };
  uv = fetchFromGitHub {
    owner = "asdf-vm"
    repo = "asdf-python"
    rev = "v0.9.1"
    sha256 = "sha256-xyz_uv_sha256"; # replace with the actual sha256 checksum for the specified revision
  };
  mermaid-cli = fetchFromGitHub {
    owner = "kubernetes-sigs"
    repo = "mermaid"
    rev = "v9.10.1"
    sha256 = "sha256-xyz_mermaid_sha256"; # replace with the actual sha256 checksum for the specified revision
  };
  just = fetchFromGitHub {
    owner = "asdf-vm"
    repo = "asdf-just"
    rev = "v0.14.3"
    sha256 = "sha256-xyz_just_sha256"; # replace with the actual sha256 checksum for the specified revision
  };
};

outputs = { self, nixpkgs, ... }: let
  system = "x86_64-linux";
in {
  devShells."${system}".default = let
    pkgs = import nixpkgs {{
      inherit system;
      stdenv.fetchFromGitHub = {
        ${python3}.fetchFromGitHub = _ => pyBuildInputs.python3;
        ${cmake}.fetchFromGitHub = _ => cmake3;
        ${ollama}.fetchFromGitHub = _ => import ollama;
        ${uv}.fetchFromGitHub = _ => import uv;
        ${mermaid-cli}.fetchFromGitHub = _ => import mermaidCli;
        ${just}.fetchFromGitHub = _ => import just;
      };
    }};
  in pkgs.mkShell {{
    name = "devShell";
    buildInputs = with pkgs; [
      # used to run LLMs locally
      ollama
      # modern python package manager
      uv
      # cli to turn mmd files into mermaid graph pngs
      mermaidCli
      # modern command runner
      just
    ];
  }};
};
```