nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  };

  outputs = { self, nixpkgs: _inputs => import {_buildNixPkgs} {self.packagePath ? null : "/":_inputs.nixpkgs.result}.builtins; }:

  devShells.default = {
    packages.build-env.enableUnfree = true;
    buildEnv = pkgs.mkShell {
      name = "basic-helloworld-dev";
      modules = [
        (import ./path/to/your/project/gitignorefiles.git-ignore)
      ];
      shellHook = ''
        echo "Using nix develop for basic project"
        export PATH="$PATH:${nixpkgs}/bin:/sbin /usr/bin
