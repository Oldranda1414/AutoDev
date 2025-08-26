

{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs";
      flake = true;
    };
  };
  outputs = { self: attrs: {
    default = self.inputs.nixpkgs.buildPythonPackage {
      pname = "example";
      version = "0.1.0";
      src = ./.;
      buildInputs = [ ];
    };
  }};
}