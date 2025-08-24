nix
{
  inputs = {
    nixpkgs.url-scoped.1 = { pkgs ? import <https://github.com/nix-community/flake.nixos.org/pkgs/spec/2024-09-14/main> };
  };

  outputs = [ ]: prevBuilds: with import (self.inputs); {

  # The flake needs to be defined here, and possibly more code can go below
  }
}
