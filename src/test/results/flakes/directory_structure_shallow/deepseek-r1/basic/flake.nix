
{
  description = "Julia project development shell";

  inputs = {
    nixpkgs.url = "nixos-unstable";
  };

  outputs = { self, nixpkgs } : {
    nixosConfigurations.default = {};

    defaultPackage = {};

    devShell = {};
    flake-utils.shell = "";
  };
}