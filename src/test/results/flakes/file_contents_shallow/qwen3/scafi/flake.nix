

{
  description = "scafi development environment";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs = { self, nixpkgs }@attrs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = {
        buildInputs = [ pkgs.scala333 ];
        shellHook = ''
          # Add any custom shell setup here
        '';
      };
    }
}