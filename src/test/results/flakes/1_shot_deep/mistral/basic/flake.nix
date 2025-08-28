 Here is an updated flake.nix file that addresses the mentioned errors:

nix
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    julia = {
      url = "github:JuliaLang/julia";
      sha256 = "your-sha256-hash-for-julia";
    };
  };

  outputs = { self , nixpkgs , julia ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
      juliaPackages = self.julia.overrideAttrs (attr: attr.withSrc ({ url = attr.url; sha256 = attr.sha256; }));
    in pkgs.mkShell {
      name = "dev-shell";
      buildInputs = [ jupyter-notebook ollama uv mermaid-cli just juliaPackages ];

      environment = pkgs.env {
        PATH = [ ./results ${pkgs.lib.systemLibraryPath}/bin $PATH ];
      };

      shellHooks = pkgs.mkShellHooks {
        buildInputsChanged = "${pkgs.mkShellHook 'pre-build-input'}/hooks/dev-shell";
      };

      hooks = {
        buildInputsChanged = "${pkgs.mkShellHook 'pre-build-input'}/hooks/dev-shell";
      };

      packages = with pkgs; [
        # Julia package manager
        juliaPackages:julia
        # Your project files
        ./basic
      ];
    };
  };
}
