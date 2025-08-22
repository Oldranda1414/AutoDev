

{
  description = "Scala project with Nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/027c93423a1e21200329f3d9cee330bbb4319201";
    scala.url = "github:NixOS/nixpkgs/027c93423a1e21200329f3d9cee330bbb4319201";
    scala.version = "2.13.10";
  };
  outputs = { self, nixpkgs, scala }@{
    defaultApp = {
      nativeBuildInputs = [ scala ];
      buildInputs = [ scala ];
      buildPhase = ''
        # Build logic here
      '';
    };
  };
}